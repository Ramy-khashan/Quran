import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/surah_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class ChangeFontShape extends StatelessWidget {
  const ChangeFontShape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahCubit, SurahState>(
      builder: (context, state) {
        final controller = SurahCubit.get(context);
        return controller.showChangeFont
            ? Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 5,
                          spreadRadius: 2)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Change Text Size",
                      style: TextStyle(
                          fontSize: getFont(20), fontWeight: FontWeight.bold),
                    ),
                    Slider.adaptive(
                      min: 18,
                      max: 40,
                      value: controller.size,
                      onChanged: (value) {
                        controller.changeSize(value);
                      },
                      label: controller.size.toString(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          controller.onChangeShowFont(false);
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.secandColor),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
