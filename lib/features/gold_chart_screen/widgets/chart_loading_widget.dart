import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'package:gold_caurd_app/core/widgets/spacing_widgets.dart';

class ChartLoadingWidget extends StatelessWidget {
  const ChartLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primaryColor),
            HeightSpace(20),
            Text(
              'Loading price history...',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}