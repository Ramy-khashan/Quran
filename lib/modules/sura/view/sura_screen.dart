import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran/quran.dart' as quran;
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/size_config.dart';
import 'widgets/change_font_sized.dart';
import 'widgets/drawer.dart';

import '../../quran_read/model/surah.dart';
import '../controller/surah_cubit.dart';

class SuraScreen extends StatelessWidget {
  final List<Surah> surah;
  final int index;
  const SuraScreen({
    super.key,
    required this.surah,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    int count = surah[index].versesCount;
    int id = surah[index].id;
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
                surah[index].arabicName,
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
              Center(
                child: ListView(
                  physics: count <= 30
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  padding:
                      count <= 30 ? EdgeInsets.zero : const EdgeInsets.all(10),
                  shrinkWrap: count <= 30 ? true : false,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          quran.basmala,
                          style: TextStyle(
                              fontFamily: "quran",
                              fontWeight: FontWeight.w600,
                              fontSize: getFont(controller.size + 6.0)),
                        ),
                      ),
                    ),
                    RichText(
                      textAlign:
                          count <= 30 ? TextAlign.center : TextAlign.right,
                      textScaleFactor: 1.2,
                      text: TextSpan(
                        children: [
                          for (var i = 1; i <= count; i++) ...{
                            TextSpan(
                              text:
                                  ' ${quran.getVerse(id, i, verseEndSymbol: false)} ${quran.getVerseEndSymbol(i)}',
                              style: TextStyle(
                                fontFamily: 'quran',
                                fontSize: getFont(controller.size),
                                leadingDistribution:
                                    TextLeadingDistribution.proportional,
                                color: Colors.black87,
                              ),
                            )
                          }
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const ChangeFontShape()
            ]),
          );
        },
      ),
    );
  }
}
