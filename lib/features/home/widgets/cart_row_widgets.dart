import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styling/app_colors.dart';

class KaratRow extends StatelessWidget {
  final String karat;
  final String subtitle;
  final double price;
  final String currency;
  final Color color;
  final bool isPremium;

  const KaratRow({
    super.key,
    required this.karat,
    required this.subtitle,
    required this.price,
    required this.currency,
    required this.color,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: isPremium ? color.withOpacity(0.1) : Colors.grey[850],
        borderRadius: BorderRadius.circular(15.r),
        border: isPremium
            ? Border.all(color: color.withOpacity(0.5), width: 2)
            : null,
      ),
      child: Row(
        children: [
          // Icon and Karat
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                karat,
                style: TextStyle(
                  color: color,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gold $karat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price.toStringAsFixed(2),
                style: TextStyle(
                  color: color,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$currency/gram',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
