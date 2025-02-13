import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/camil_case.dart';
import 'package:quran_app/core/widgets/loading_item.dart';

import '../../../core/repository/hadiths_details/hadiths_details_repository_impl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/function/convert_to_arabic.dart';
import '../../../core/utils/service_locator.dart';
import '../../../core/widgets/arrow_moving.dart';
import '../controller/hadith_details_cubit.dart';

class HadithsDetailsScreen extends StatelessWidget {
  const HadithsDetailsScreen(
      {super.key, required this.slug, required this.name});
  final String slug;
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HadithDetailsCubit(sl.get<HadithsDetailsRepositoryImpl>())
            ..getHadithsDetails(slug: slug),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            camilCaseMethod(name),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: Platform.isAndroid ? 70 : 50,
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HadithDetailsCubit, HadithDetailsState>(
          builder: (context, state) {
            final controller = HadithDetailsCubit.get(context);
            return controller.isLoading
                ? const LoadingItem()
                : controller.isFaild
                    ? const Center(
                        child: Text("SomeThing went wrong, Try again later."),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Stack(children: [
                              PageView.builder(
                                onPageChanged: (index) =>
                                    controller.getPageIndex(index),
                                physics: const BouncingScrollPhysics(),
                                controller: controller.pageController,
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.all(12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors
                                              .primaryColor
                                              .withOpacity(.7),
                                          child: Text(
                                            convertToArabic(controller
                                                .hadiths[index].number
                                                .toString()),
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        SelectableText(
                                          controller.hadiths[index].arab
                                              .toString(),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(fontSize: 21),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                itemCount: controller.hadiths.length,
                              ),
                              ArrowMovingItem(
                                width: controller.pageIndex + 1 ==
                                            controller.hadiths.length ||
                                        controller.hadiths.length == 1
                                    ? 0
                                    : 70,
                                height: controller.pageIndex + 1 ==
                                            controller.hadiths.length ||
                                        controller.hadiths.length == 1
                                    ? 0
                                    : 70,
                                isLeft: false,
                                onTap: () {
                                  controller.changePage(nextPage: true);
                                },
                              ),
                              ArrowMovingItem(
                                width: controller.pageIndex != 0 ? 70 : 0,
                                height: controller.pageIndex != 0 ? 70 : 0,
                                isLeft: true,
                                onTap: () {
                                  controller.changePage(nextPage: false);
                                },
                              ),
                            ]),
                          ),
                          controller.isLaodingForMore
                              ? const LoadingItem()
                              : const SizedBox()
                        ],
                      );
          },
        ),
      ),
    );
  }
}
