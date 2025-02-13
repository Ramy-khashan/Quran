import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_app/core/utils/function/convert_to_arabic.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../full_quran/model/full_quran_model.dart';
import '../sura_screen.dart';

class SurahDrawer extends StatelessWidget {
  const SurahDrawer({super.key, required this.surah, required this.index});
  final List<FullQuranModel> surah;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: Colors.grey.shade400)
                ],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
            child: SafeArea(
              child: ListTile(
                  title: Center(
                      child: Text(
                "قرأن",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: getFont(60),
                    letterSpacing: 1.2,
                    fontFamily: "Aldhabi"),
              ))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: surah.length,
              itemBuilder: (context, i) => ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullQuranSuraScreen(surah: surah, index: i),
                      ));
                },
                trailing: Text(
                  surah[i].arabicName,
                  style: TextStyle(
                      fontSize: getFont(24),
                      fontFamily: Platform.isIOS ? "iosQuran" : "quran"),
                ),
                leading: CircleAvatar(
                  child: Text(
                    convertToArabic(surah[i].id.toString()),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
