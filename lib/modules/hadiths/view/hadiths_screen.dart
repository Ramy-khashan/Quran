import 'package:flutter/material.dart';
import '../../../core/data/hadith_data.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/function/convert_to_arabic.dart';
import '../../hadith_details/view/hadiths_details_screen.dart';

class HadithsScreen extends StatelessWidget {
  const HadithsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: const Text(
              "الأحاديث",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 70,
                  letterSpacing: 1.2,
                  fontFamily: "Aldhabi"),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(7),
              itemBuilder: (context, index) {
                return Card(
                  color: index % 2 == 0
                      ? Colors.grey.shade200
                      : AppColors.primaryColor.withOpacity(.7),
                  elevation: 0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HadithsDetailsScreen(
                              name: HadithData.hadith[index].name.toString(),
                              slug: HadithData.hadith[index].slug.toString(),
                            ),
                          ));
                    },
                    title: Text(
                      HadithData.hadith[index].name.toString(),
                      style: TextStyle(
                          color: index % 2 == 0 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 23),
                    ),
                    subtitle: Text(
                      "عدد الحاديث : ${convertToArabic(HadithData.hadith[index].total.toString())}",
                      style: TextStyle(
                        fontSize: 20,
                        color: index % 2 == 0 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
              itemCount: HadithData.hadith.length)),
    );
  }
}
