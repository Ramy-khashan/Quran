import 'dart:io';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/camil_case.dart';
import '../controller/tasbih_cubit.dart';

class TasbihScreen extends StatelessWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasbihCubit()..getPrayer(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            camilCaseMethod("تسابيح"),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 50,
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<TasbihCubit, TasbihState>(
          builder: (context, state) {
            final controller = TasbihCubit.get(context);
            return Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text(
                  "عدد التسبيحات",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: Platform.isIOS ? "iosQuran" : "quran"),
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 500),
                  value: controller.tasbih, //

                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: Platform.isIOS ? "iosQuran" : "quran"),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTapUp: (val) => controller.onTapUp(),
                      onTapDown: (val) => controller.onTapDown(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 180,
                        height: 185,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            // borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                            shape: BoxShape.circle,
                            boxShadow: controller.isPressed
                                ? null
                                : [
                                    const BoxShadow(
                                        offset: Offset(-2, -2),
                                        color: AppColors.primaryColor,
                                        spreadRadius: 1,
                                        blurRadius: 10),
                                    const BoxShadow(
                                        offset: Offset(3, 3),
                                        color: Colors.black54,
                                        spreadRadius: .5,
                                        blurRadius: 10),
                                  ],
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  controller.isPressed
                                      ? Colors.black
                                      : AppColors.primaryColor,
                                  controller.isPressed
                                      ? AppColors.primaryColor
                                      : Colors.black54,
                                ])),
                        child: Image.asset(
                          "assets/images/prayer.png",
                          color: Colors.white54,
                          width: 130,
                          height: 135,
                          scale: 9,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        controller.reset();
                      },
                      child: const Icon(Icons.restart_alt),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
