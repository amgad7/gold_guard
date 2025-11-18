import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'package:gold_caurd_app/core/widgets/spacing_widgets.dart';


class ChartHeaderWidget extends StatelessWidget {
  const ChartHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.show_chart,
              color: AppColors.primaryColor,
              size: 32.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'Price Analysis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        HeightSpace(8),
        Text(
          'Track gold price movements over time',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}