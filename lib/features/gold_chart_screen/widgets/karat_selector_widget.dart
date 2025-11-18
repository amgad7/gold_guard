import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'package:gold_caurd_app/core/widgets/spacing_widgets.dart';

class KaratSelectorWidget extends StatelessWidget {
  final String selectedKarat;
  final Function(String) onKaratChanged;

  const KaratSelectorWidget({
    super.key,
    required this.selectedKarat,
    required this.onKaratChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Karat',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 13.sp,
            ),
          ),
          HeightSpace(12),
          Row(
            children: [
              _buildKaratButton('24K', AppColors.primaryColor),
              SizedBox(width: 10.w),
              _buildKaratButton('21K', Colors.amber),
              SizedBox(width: 10.w),
              _buildKaratButton('18K', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Color _getKaratColor(String karat) {
    switch (karat) {
      case '21K':
        return Colors.amber;
      case '18K':
        return Colors.orange;
      default:
        return AppColors.primaryColor;
    }
  }

  Widget _buildKaratButton(String karat, Color color) {
    final isSelected = selectedKarat == karat;
    return Expanded(
      child: GestureDetector(
        onTap: () => onKaratChanged(karat),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.grey[850],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              karat,
              style: TextStyle(
                color: isSelected ? color : AppColors.secondaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}