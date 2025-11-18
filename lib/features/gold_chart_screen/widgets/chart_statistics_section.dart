import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'stat_card_widget.dart';

class ChartStatisticsSection extends StatelessWidget {
  final String highestPrice;
  final String lowestPrice;
  final String averagePrice;
  final String priceChange;
  final bool isPriceUp;

  const ChartStatisticsSection({
    super.key,
    required this.highestPrice,
    required this.lowestPrice,
    required this.averagePrice,
    required this.priceChange,
    required this.isPriceUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCardWidget(
                label: 'Highest',
                value: '\$$highestPrice',
                icon: Icons.arrow_upward,
                color: Colors.green,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: StatCardWidget(
                label: 'Lowest',
                value: '\$$lowestPrice',
                icon: Icons.arrow_downward,
                color: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: StatCardWidget(
                label: 'Average',
                value: '\$$averagePrice',
                icon: Icons.trending_flat,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: StatCardWidget(
                label: 'Change',
                value: '${isPriceUp ? '+' : ''}$priceChange',
                icon: Icons.show_chart,
                color: isPriceUp ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}