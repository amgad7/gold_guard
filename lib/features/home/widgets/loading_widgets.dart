import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styling/app_colors.dart';
import '../../../core/widgets/spacing_widgets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          HeightSpace(100),
          CircularProgressIndicator(
            color: AppColors.primaryColor,
            strokeWidth: 3,
          ),
          HeightSpace(20),
          Text(
            'Loading gold prices...',
            style: TextStyle(color: AppColors.secondaryColor, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
