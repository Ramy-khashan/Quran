import 'dart:io';

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              color: AppColors.primaryColor,
              backgroundColor: AppColors.primaryColor.withOpacity(.4),
            )
          : const CircularProgressIndicator.adaptive(),
    );
  }
}
