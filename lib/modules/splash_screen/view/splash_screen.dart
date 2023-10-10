import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran_app/modules/navigator_bar/view/navigator_bar.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/function/shared_preferance_utils.dart';
import '../../../core/utils/size_config.dart';
import '../../onboarding/view/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreferenceUtils.getString("onBoarding") != "true"
                    ? const OnBoardingScreen()
                    : const NavigatorBarScreen(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.splash,
          width: getWidth(370),
          height: getHeight(370),
        ),
      ),
    );
  }
}
