import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:quran_app/modules/prayers/controller/prayers_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/camil_case.dart';
import '../../../core/utils/size_config.dart';

class PrayersScreen extends StatelessWidget {
  const PrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayersCubit()..getPrayer(),
      child: Scaffold(
        appBar: AppBar(
         
          backgroundColor: AppColors.primaryColor,
          title: Text(
            camilCaseMethod("Tasbih"),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: getFont(80),
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<PrayersCubit, PrayersState>(
          builder: (context, state) {
            final controller = PrayersCubit.get(context);
            return Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                const Text(
                  "Number of prayers Today",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: "quran"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.prayers.toString(),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: "quran"),
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
                 
              ],
            );
          },
        ),
      ),
    );
  }
}
