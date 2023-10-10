import 'package:flutter/material.dart';

import '../../quran.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/size_config.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(getHeight(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppAssets.errorNetwork,
                scale: 2,
              ),
              SizedBox(
                height: getHeight(15),
              ),
              Text(
                "Something went wrong cause your internet connection, Check your network!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getFont(25), fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: getHeight(50),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuranApp()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(30))),
                  child: Text(
                    "Reload",
                    style: TextStyle(
                        fontSize: getFont(25),
                        fontWeight: FontWeight.w700,
                         color: AppColors.primaryColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
