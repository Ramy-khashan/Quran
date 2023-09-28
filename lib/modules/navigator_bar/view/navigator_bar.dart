import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/app_colors.dart';
import 'package:quran_app/core/utils/size_config.dart';

import '../controller/navigator_bar_cubit.dart';

class NavigatorBarScreen extends StatelessWidget {
  const NavigatorBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => NavigatorBarCubit(),
      child: BlocBuilder<NavigatorBarCubit, NavigatorBarState>(
        builder: (context, state) {
          final controller = NavigatorBarCubit.get(context);
          return Scaffold(
            body: controller.pages[controller.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: AppColors.primaryColor,
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromARGB(255, 224, 224, 224),  fontFamily:"head",),
              selectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 15,  color: AppColors.primaryColor, fontFamily:"head",),
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/mosque-icon.png",
                      cacheWidth: 50,
                      color: AppColors.primaryColor,
                      cacheHeight: 50,
                    ),
                    label: "Home "),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/hadiths.png",
                      cacheWidth:50,
                      cacheHeight: 50,
                    ),
                    label: "Hadiths"),  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/azkar.png",
                      cacheWidth:50, 

                      cacheHeight: 50,
                    ),
                    label: "Azkar"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/prayer.png",
                      cacheWidth: 50,
                      color: AppColors.primaryColor,
                      cacheHeight: 50,
                    ),
                    label: "Tasbih"),
              ],
              currentIndex: controller.selectedIndex,
              onTap: (value) {
                controller.changePage(value);
              },
            ),
          );
        },
      ),
    );
  }
}
