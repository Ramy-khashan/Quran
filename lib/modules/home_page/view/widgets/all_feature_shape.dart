import 'package:flutter/material.dart'; 

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart'; 
import '../../../qiblah/view/qiblah_screen.dart';
import '../../../quran_read/view/quran_screen.dart';
import '../../../quran_sound/view/quran_soun_screen.dart';

class AllFeaturesShape extends StatelessWidget {
  const AllFeaturesShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const QuranScreen(),));},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    AppAssets.logo,
                    width: 35,
                    color: Colors.white,
                    height: 35,
                  ),
                ),
              ),
              const Text(
                "Quran\nRead",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const QuranSoundScreen() ,));},
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    Icons.volume_down_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Quran\nVoice",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
  InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const QiblahCompassScreen() ,));},
        
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    Icons.compass_calibration_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Qibla",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: AppColors.primaryColor,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.radio,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "Live\nRadio",
              textAlign: TextAlign.center,
            )
          ],
        )
      ],
    );
  }
}
