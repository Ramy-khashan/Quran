import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controller/surah_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class ChangeFontShape extends StatelessWidget {
  const ChangeFontShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<SurahCubit, SurahState>(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CupertinoCheckbox(
                            value: controller.isEnableEn,
                            onChanged: (value) {
                              controller.changeEnableEn(value);
                            },
                            activeColor: AppColors.secandColor,
                          ),
                          const Text(
                            "الأنجلزي",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoCheckbox(
                            value: controller.istafseer,
                            onChanged: (value) {
                              controller.changeTafseer(value);
                            },
                            activeColor: AppColors.secandColor,
                          ),
                          const Text(
                            "التفسر ( التفسير الميسر )",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      
                      ListTile(
                        onTap: (){print("Download");}, 
                          leading: Icon(FontAwesomeIcons.download),
                          title: Text(
                            "تحميل السوره كامله",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "تغير حجم الخط",
                          style: TextStyle(
                              fontSize: getFont(20),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Slider.adaptive(
                        min: 18,
                        max: 40,
                        value: controller.size,
                        onChanged: (value) {
                          controller.changeSize(value);
                        },
                        label: controller.size.toString(),
                        activeColor: AppColors.primaryColor.withOpacity(.7),
                        thumbColor: AppColors.primaryColor,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            controller.onChangeShowFont(false);
                          },
                          borderRadius: BorderRadius.circular(5),
                          child: const Text(
                            "إلغاء",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                                fontSize: 20,
                                color: AppColors.secandColor),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
