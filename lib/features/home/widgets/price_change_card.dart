import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/gold_price_model.dart';

class PriceChangeCard extends StatelessWidget {
  final GoldPriceModel model;

  const PriceChangeCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final bool isPriceUp = model.isPriceUp;
    final Color changeColor = isPriceUp ? Colors.green : Colors.red;
    final IconData changeIcon = isPriceUp
        ? Icons.trending_up
        : Icons.trending_down;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPriceUp
              ? [Colors.green.withOpacity(0.2), Colors.green.withOpacity(0.05)]
              : [Colors.red.withOpacity(0.2), Colors.red.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: changeColor.withOpacity(0.3), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(changeIcon, color: changeColor, size: 40.sp),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPriceUp ? 'Price is Up' : 'Price is Down',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                '${isPriceUp ? '+' : ''}${model.formattedChange} USD (${model.formattedChangePercent})',
                style: TextStyle(
                  color: changeColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
