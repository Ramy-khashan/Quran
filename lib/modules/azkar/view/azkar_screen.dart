import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_app/core/data/azkar_data.dart';
import 'package:quran_app/core/utils/function/convert_to_arabic.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/camil_case.dart';
import '../../azkar_details/view/azkar_detailsl_screen.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            camilCaseMethod("الأذكار"),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: Platform.isAndroid ? 70 : 50,
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body: ListView.separated(
            padding: const EdgeInsets.all(3),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: index % 2 == 0
                    ? Colors.grey.shade200
                    : AppColors.primaryColor.withOpacity(.7),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AzkarDetailsScreen(
                          id: AzkarData.azkarData[index].id,
                          title: AzkarData.azkarData[index].title,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: index % 2 == 0
                        ? AppColors.primaryColor.withOpacity(.7)
                        : Colors.grey.shade200,
                    child: Text(
                      convertToArabic(
                          (AzkarData.azkarData[index].id).toString()),
                      style: TextStyle(
                          color: index % 2 == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  title: Text(
                    AzkarData.azkarData[index].title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: index % 2 == 0 ? Colors.black : Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: Platform.isIOS ? "iosQuran" : "quran"),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: index % 2 == 0 ? Colors.black : Colors.white,
                  ),
                ),
              );
            },
            itemCount: AzkarData.azkarData.length));
  }
}
