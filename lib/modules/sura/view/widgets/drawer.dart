import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../quran_read/model/surah.dart';
import '../sura_screen.dart';

class SurahDrawer extends StatelessWidget {
  const SurahDrawer({super.key, required this.surah, required this.index});
  final List<Surah> surah;
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
                "Quran",
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
              itemBuilder: (context, i) => ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SuraScreen(surah: surah, index: i),
                      ));
                },
                trailing: Text(
                  surah[i].arabicName,
                  style: TextStyle(fontSize: getFont(24), fontFamily: "quran"),
                ),
                leading: CircleAvatar(
                  child: Text(
                    surah[i].id.toString(),
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
