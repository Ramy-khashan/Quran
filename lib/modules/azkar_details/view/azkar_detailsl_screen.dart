import 'dart:io';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quran_app/core/widgets/arrow_moving.dart';
import '../../../core/repository/azkar/azkar_repository_impl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/function/convert_to_arabic.dart';
import '../../../core/utils/service_locator.dart';
import '../controller/azkar_detailsl_cubit.dart';

class AzkarDetailsScreen extends StatelessWidget {
  const AzkarDetailsScreen({super.key, required this.id, required this.title});
  final int id;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ValueListenableBuilder(
          valueListenable: Hive.box(AppString.azkarHiveBox).listenable(),
          builder: (context, box, child) {
            var azkar = box.getAt(id - 1);

            return BlocProvider(
              create: (context) =>
                  AzkarDetailsCubit(sl.get<AzkarRepositoryImpl>())
                    ..generateList(List.from(azkar).length),
              child: BlocBuilder<AzkarDetailsCubit, AzkarDetailslState>(
                builder: (context, state) {
                  final controller = AzkarDetailsCubit.get(context);
                  return Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.arrowRight,
                              color: Colors.white,
                            )),
                        backgroundColor: AppColors.primaryColor,
                        title: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              letterSpacing: 1.2,
                              fontFamily: "Kitab"),
                        ),
                        centerTitle: true,
                        bottom: PreferredSize(
                            preferredSize: const Size(double.infinity, 30),
                            child: Row(
                              children: [
                                CupertinoCheckbox(
                                    side: const BorderSide(
                                        color: Colors.white, width: 2),
                                    value: controller.isEnableEn,
                                    activeColor: AppColors.secandColor,
                                    onChanged: (value) {
                                      controller.changeEnableEn(value);
                                    }),
                                const Text(
                                  "اللغه الأنجليزيه",
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                      ),
                      body: Stack(
                        children: [
                          PageView.builder(
                            controller: controller.pageController,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (index) {
                              controller.getPageIndex(index);
                            },
                            itemCount: List.from(azkar).length,
                            itemBuilder: (context, index) => Scaffold(
                              floatingActionButtonLocation:
                                  FloatingActionButtonLocation.centerFloat,
                              floatingActionButton: InkWell(
                                onTap: () {
                                  controller.increase(
                                      index: index,
                                      quantity: List.from(azkar)[index].rEPEAT);
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        AppColors.primaryColor.withOpacity(.5),
                                        AppColors.primaryColor,
                                      ]),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                            color: Colors.grey,
                                            offset: Offset(1, 3))
                                      ],
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: AnimatedFlipCounter(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      value: controller.counterList[index], //
                                      textStyle: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              body: SingleChildScrollView(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    right: 8.0,
                                    left: 8.0,
                                    bottom: 120),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: controller.selectedOne ==
                                                  index
                                              ? () async {
                                                  controller.stop();
                                                }
                                              : () async {
                                                  await controller.play(
                                                      List.from(azkar)[index]
                                                          .aUDIO,
                                                      index);
                                                },
                                          icon: CircleAvatar(
                                            child: Icon(
                                                controller.selectedOne == index
                                                    ? FontAwesomeIcons.pause
                                                    : FontAwesomeIcons.play),
                                          ),
                                        ),
                                        Text(
                                          "( قم بتكرار عدد ${convertToArabic(List.from(azkar)[index].rEPEAT.toString())} مره )",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SelectableText(
                                      List.from(azkar)[index]
                                                  .aRABICTEXT
                                                  .toString() ==
                                              "null"
                                          ? List.from(azkar)[index]
                                              .text
                                              .toString()
                                          : List.from(azkar)[index]
                                              .aRABICTEXT
                                              .toString()
                                              .toString(),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style:   TextStyle(
                                          fontSize: 25,
                                          fontFamily:
                                              Platform.isIOS ? "iosQuran" : "quran"),
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    controller.isEnableEn
                                        ? SelectableText(
                                            List.from(azkar)[index]
                                                .tRANSLATEDTEXT
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            textDirection: TextDirection.ltr,
                                            style: const TextStyle(
                                              fontSize: 23,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ArrowMovingItem(
                            width: controller.pageIndex + 1 ==
                                        List.from(azkar).length ||
                                    List.from(azkar).length == 1
                                ? 0
                                : 70,
                            height: controller.pageIndex + 1 ==
                                        List.from(azkar).length ||
                                    List.from(azkar).length == 1
                                ? 0
                                : 70,
                            isLeft: false,
                            onTap: () {
                              controller.changeePage(nextPage: true);
                            },
                          ),
                          ArrowMovingItem(
                            width: controller.pageIndex != 0 ? 70 : 0,
                            height: controller.pageIndex != 0 ? 70 : 0,
                            isLeft: true,
                            onTap: () {
                              controller.changeePage(nextPage: false);
                            },
                          ),
                        ],
                      ));
                },
              ),
            );
          }),
    );
  }
}
