import 'dart:async';

import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/size_config.dart';

import '../../home_page/view/home_page_screen.dart';

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
            builder: (context) => const HomePageScreen(),
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
          AppAssets.logo,
          width: getWidth(250),
          height: getHeight(250),
        ),
      ),
    );
  }
}
