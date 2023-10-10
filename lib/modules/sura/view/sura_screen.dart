import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_app/core/utils/app_colors.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_string.dart';
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ValueListenableBuilder(
        valueListenable: Hive.box(AppString.quranHiveBox).listenable(),
        builder: (context, box, child) {
          var quran = box.getAt(index);
          return BlocProvider(
            create: (context) => SurahCubit()
              ..getFontSize()
              ..allSura(quran, surah[index].nameAr),
            child: BlocBuilder<SurahCubit, SurahState>(
              builder: (context, state) {
                final controller = SurahCubit.get(context);
                return GestureDetector(
                  onTap: () {
                    controller.onChangeShowFont(false);
                  },
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    key: controller.scaffoldKey,
                    endDrawer: SurahDrawer(surah: surah, index: index),
                    appBar: AppBar(
                      elevation: 0,
                      title: Text(
                        surah[index].nameAr,
                        style: const TextStyle(
                            fontSize: 25,
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
                            controller.scaffoldKey.currentState!
                                .openEndDrawer();
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
                      bottom: PreferredSize(
                          preferredSize: const Size(double.infinity, 50),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.isPlaying
                                      ? controller.pauseFullAudio()
                                      : controller.playFullAudio();
                                },
                                icon: CircleAvatar(
                                  backgroundColor:
                                      AppColors.secandColor.withOpacity(.8),
                                  child: Icon(
                                    !controller.isPlaying
                                        ? FontAwesomeIcons.play
                                        : FontAwesomeIcons.pause,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                "تشغيل السوره كامله",
                                style: TextStyle(fontSize: 18),
                              ),
//                               FloatingActionButton(onPressed: (){
// // controller.scroll.jumpTo(double.parse(audioPlayer!.currentIndexStream.toString()));

//                               },child: Icon(Icons.find_in_page_rounded),)
                            ],
                          )),
                    ),
                    body: Stack(children: [
                      ListView.builder(
                          padding: const EdgeInsets.all(3),
                          itemCount: List.from(quran).length,
                          controller: controller.scroll,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(7),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.amber.withOpacity(.15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.play(quran[index],
                                            surah[this.index].nameAr);
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: AppColors.primaryColor
                                            .withOpacity(.7),
                                        child: const Icon(
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
                                    style: TextStyle(
                                        fontSize: controller.size,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "quran"),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  controller.istafseer
                                      ? SelectableText(
                                          "التفسير :\n${quran[index].tafser}",
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                    height: controller.istafseer ? 14 : 0,
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    height: controller.isEnableEn ? null : 0,
                                    child: Text(
                                      quran[index].textEn,
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "head"),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                      const ChangeFontShape()
                    ]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
