import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/app_colors.dart';
import 'package:quran_app/core/utils/size_config.dart';
import 'package:quran_app/modules/navigator_bar/view/navigator_bar.dart';

import '../../../core/utils/function/shared_preferance_utils.dart';
import '../controller/onboarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                PreferenceUtils.setString("onBoarding", "true");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigatorBarScreen(),
                    ),
                    (route) => false);
              },
              child: const Text(
                "تخطي",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor),
              ),
            ),
          ],
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final controller = OnboardingCubit.get(context);
            return Column(
              children: [
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      controller.getPageNumber(index);
                    },
                    itemCount: controller.onboardingItem.length,
                    itemBuilder: (context, index) => Image.asset(
                      "assets/images/${controller.onboardingItem[index].image}",
                      cacheHeight: 330,
                      cacheWidth: index == 1 ? 350 : 300,
                      scale: index == 2 ? 0.7 : 1,
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(220),
                          child: Column(
                            children: [
                              Text(
                                controller
                                    .onboardingItem[controller.selectedPage]
                                    .title,
                                style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "head"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller
                                      .onboardingItem[controller.selectedPage]
                                      .description
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      fontFamily:
                                          Platform.isIOS ? "iosQuran" : "quran"),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(25),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                controller.onboardingItem.length,
                                (index) => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      margin: const EdgeInsets.only(right: 10),
                                      width: getWidth(
                                        index == controller.selectedPage
                                            ? 35
                                            : 12,
                                      ),
                                      height: getHeight(13),
                                      decoration: BoxDecoration(
                                          color:
                                              index == controller.selectedPage
                                                  ? AppColors.primaryColor
                                                  : AppColors.secandColor
                                                      .withOpacity(.8),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    )),
                          ),
                        ),
                        SizedBox(
                          height:
                              getHeight(controller.selectedPage == 3 ? 25 : 0),
                        ),
                        controller.selectedPage == 3
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10)),
                                onPressed: () {
                                  PreferenceUtils.setString(
                                      "onBoarding", "true");

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NavigatorBarScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text(
                                  "بدأ التطبيق",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ))
                            : const SizedBox.shrink()
                      ],
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
