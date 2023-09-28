import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_app/core/utils/app_colors.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/size_config.dart';
import '../../quran_read/model/surah_head_model.dart';
import 'widgets/change_font_sized.dart';
import 'widgets/drawer.dart';

import '../controller/surah_cubit.dart';

class SuraScreen extends StatelessWidget {
  final List<QuranSurahModel> surah;
  final int index;
  const SuraScreen({
    super.key,
    required this.surah,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurahCubit()..getFontSize(),
      child: BlocBuilder<SurahCubit, SurahState>(
        builder: (context, state) {
          final controller = SurahCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            key: controller.scaffoldKey,
            endDrawer: SurahDrawer(surah: surah, index: index),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                surah[index].nameAr,
                style: TextStyle(
                    fontSize: getFont(40),
                    letterSpacing: 1.2,
                    fontFamily: "quran"),
              ),
              backgroundColor: Colors.white,
              scrolledUnderElevation: .5,
              centerTitle: true,
              actions: [
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    controller.scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      AppAssets.logo,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.onChangeShowFont(true);
                    },
                    icon: const Icon(Icons.linear_scale_outlined))
              ],
            ),
            body: Stack(children: [
              ValueListenableBuilder(
                  valueListenable:
                      Hive.box(AppString.quranHiveBox).listenable(),
                  builder: (context, box, child) {
                    var quran = box.getAt(index);
                    return ListView.builder(
                      padding: const EdgeInsets.all(3),
                      itemCount: List.from(quran).length,
                      itemBuilder: (context, index) {
                        return  
               
                           Container(
                                    margin: const EdgeInsets.all(7),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        // color: const Color.fromARGB(255, 138, 246, 223)
                                        color: AppColors.secandColor
                                            .withOpacity(.3)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () {
                                              controller
                                                  .play(quran[index].audio);
                                            },
                                            icon: const CircleAvatar(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              child: Icon(
                                                FontAwesomeIcons.play,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SelectableText(
                                           quran[index].textAr.toString(),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style:   TextStyle(
                                              fontSize: controller.size,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "quran"),
                                        ),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          quran[index].textEn,
                                          textAlign: TextAlign.left,
                                          textDirection: TextDirection.ltr,
                                          style: const TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "head"),
                                        ),
                                      ],
                                    ),
                                  ) 
                         ;
                      },
                    );
                  }),
              const ChangeFontShape()
            ]),
          );
        },
      ),
    );
  }
}
