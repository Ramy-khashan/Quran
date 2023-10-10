// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:quran/quran.dart' as quran;
// import '../../../core/utils/app_assets.dart';
// import '../../../core/utils/size_config.dart';
import '../../full_quran/model/full_quran_model.dart';
// import 'widgets/change_font_sized.dart';
import 'widgets/drawer.dart';

import '../controller/surah_cubit.dart';

class FullQuranSuraScreen extends StatelessWidget {
  final List<FullQuranModel> surah;
  final int index;
  const FullQuranSuraScreen({
    super.key,
    required this.surah,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // int count = surah[index].versesCount;
    // int id = surah[index].id;
    return BlocProvider(
      create: (context) => FullQuranSuraCubit()
        ..getFontSize()
        ..getPage(surah[index].pages.first),
      child: BlocBuilder<FullQuranSuraCubit, FullQuranSuraState>(
        builder: (context, state) {
          final controller = FullQuranSuraCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            key: controller.scaffoldKey,
            endDrawer: SurahDrawer(surah: surah, index: index),
            appBar: AppBar(
              backgroundColor: Colors.amber.withOpacity(.1),
              title: Text(
                surah[index].arabicName,
                // (${controller.selectedPage} ص )",
                style: const TextStyle(
                    fontSize: 30, letterSpacing: 1.2, fontFamily: "quran"),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                color: Colors.amber.withOpacity(.1),
                child: PageView(
                  onPageChanged: (page) {},
                  children: [
                    for (int i = surah[index].pages.first;
                        i <= surah[index].pages.last;
                        i++) ...{
                      // ...controller.getPage(i),
                      Image.asset(
                        'assets/images/quran_image/$i.png',
                        fit: BoxFit.fill,
                      ),
                    }
                  ],
                ),
              ),
            ),
            // appBar: AppBar(
            //   elevation: 0,
            //   title: Text(
            //     surah[index].arabicName,
            //     style: TextStyle(
            //         fontSize: getFont(40),
            //         letterSpacing: 1.2,
            //         fontFamily: "quran"),
            //   ),
            //   backgroundColor: Colors.white,
            //   scrolledUnderElevation: .5,
            //   centerTitle: true,
            //   actions: [
            //     InkWell(
            //       borderRadius: BorderRadius.circular(30),
            //       onTap: () {
            //         controller.scaffoldKey.currentState!.openEndDrawer();
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.all(5.0),
            //         child: Image.asset(
            //           AppAssets.logo,
            //           width: 25,
            //           height: 25,
            //         ),
            //       ),
            //     ),
            //     IconButton(
            //         onPressed: () {
            //           controller.onChangeShowFont(true);
            //         },
            //         icon: const Icon(Icons.linear_scale_outlined))
            //   ],
            // ),
            // body: Stack(children: [
            //   Center(
            //     child: ListView(
            //       physics: const BouncingScrollPhysics(),
            //       // padding:
            //       //     count <= 30 ? EdgeInsets.zero : const EdgeInsets.all(10),
            //       shrinkWrap: count <= 30 ? true : false,
            //       children: [
            //         Center(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               quran.basmala,
            //               style: TextStyle(
            //                   fontFamily: "quran",
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: getFont(controller.size + 6.0)),
            //             ),
            //           ),
            //         ),
            //         RichText(
            //           textAlign:
            //               count <= 30 ? TextAlign.center : TextAlign.right,
            //           textScaleFactor: 1.2,
            //           text: TextSpan(
            //             locale: const Locale("ar"),
            //               children: List.generate(
            //                   count,
            //                   (index) => TextSpan(
            //                         text:
            //                             ' ${quran.getVerse(id, index+1, verseEndSymbol: false)} ${quran.getVerseEndSymbol(index+1)}',

            //                         style: const TextStyle(
            //                         overflow: TextOverflow.fade,
            //                           fontFamily: 'quran',
            //                           fontSize: 20,
            //                           locale: Locale("ar"),
            //                           fontVariations: <FontVariation>[
            //                             FontVariation('wght', 900.0)
            //                           ],
            //                           color: Colors.black87,
            //                         ),
            //                       ))),
            //         ),
            //       ],
            //     ),
            //   ),
            //   const ChangeFontShape()
            // ]),
          );
        },
      ),
    );
  }
}
