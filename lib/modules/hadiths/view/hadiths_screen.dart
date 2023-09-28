import 'package:flutter/material.dart';  
import '../../../core/data/hadith_data.dart'; 
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../hadith_details/view/hadiths_details_screen.dart';

class HadithsScreen extends StatelessWidget {
  const HadithsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Hadiths",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: getFont(80),
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body:  ListView.builder(
                        padding: const EdgeInsets.all(7),
                        itemBuilder: (context, index) {
                            return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HadithsDetailsScreen(
                                        name:  HadithData.hadith[index].name
                                            .toString(),
                                        slug:  HadithData.hadith[index].slug
                                            .toString(),
                                      ),
                                    ));
                              },
                              title: Text(
                               HadithData.hadith[index].name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              subtitle: Text(
                                  "Hadiths Number : ${ HadithData.hadith[index].total}"),
                            ),
                          );
                        },
                        itemCount:  HadithData.hadith.length) 
         
     
    );
  }
}
