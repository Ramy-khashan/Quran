import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = const SizedBox(height: 32);
    final errorColor = AppColors.primaryColor;

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 150,
              color: errorColor,
            ),
            box,
            Text(
              error!,
              style: TextStyle(color: errorColor, fontWeight: FontWeight.bold),
            ),
            box,
            ElevatedButton(
              child: const Text("Retry"),
              onPressed: () {
                if (callback != null) callback!();
              },
            )
          ],
        ),
      ),
    );
  }
}
