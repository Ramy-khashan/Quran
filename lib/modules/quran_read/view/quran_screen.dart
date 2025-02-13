import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data/surah_head_data.dart';
import '../../../core/utils/app_colors.dart';
import '../../sura/view/sura_screen.dart';

import '../controller/quran_reading_cubit.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QuranReadingCubit(),
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
                "قرأن",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: Platform.isAndroid ? 70 : 50,
                    letterSpacing: 1.2,
                    fontFamily: "Aldhabi"),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<QuranReadingCubit, QuranReadingState>(
              builder: (context, state) {
                return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    leading: Image.asset(
                      SurahHeadData.surahhead[index].revelationType == "Meccan"
                          ? "assets/images/meccan.png"
                          : "assets/images/medinan.png",
                      cacheHeight: 30,
                      cacheWidth: 30,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          SurahHeadData.surahhead[index].nameAr,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily:
                                  Platform.isIOS ? "iosQuran" : "quran"),
                        ),
                        Text(
                          SurahHeadData.surahhead[index].nameEn,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style:
                              const TextStyle(fontSize: 20, fontFamily: "head"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => SuraScreen(
                                surah: SurahHeadData.surahhead, index: index)),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemCount: SurahHeadData.surahhead.length,
                );
              },
            )));
  }
}
