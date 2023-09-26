import 'package:flutter/material.dart';
import 'package:quran_app/core/data/azkar_data.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/camil_case.dart';
import '../../../core/utils/size_config.dart';
import '../../azkar_details/view/azkar_detailsl_screen.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            camilCaseMethod("Azkar"),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: getFont(80),
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
            itemBuilder: (context, index) {
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.grey.shade200,
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
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      (AzkarData.azkarData[index].id).toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    AzkarData.azkarData[index].title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: "quran"),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              );
            },
            itemCount: AzkarData.azkarData.length));
  }
}
