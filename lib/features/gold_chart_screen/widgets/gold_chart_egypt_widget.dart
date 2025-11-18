import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'package:gold_caurd_app/core/widgets/spacing_widgets.dart';

class GoldChartEgyptWidget extends StatelessWidget {
  final String selectedKarat;
  final List<FlSpot> chartData;
  final List<String> days;
  final bool isPriceUp;
  final String changePercentage;
  final Color karatColor;

  const GoldChartEgyptWidget({
    super.key,
    required this.selectedKarat,
    required this.chartData,
    required this.days,
    required this.isPriceUp,
    required this.changePercentage,
    required this.karatColor,
  });

  double getMinPrice() {
    if (chartData.isEmpty) return 3000;
    final minVal = chartData.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    return (minVal * 0.95).floorToDouble();
  }

  double getMaxPrice() {
    if (chartData.isEmpty) return 5000;
    final maxVal = chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return (maxVal * 1.05).ceilToDouble();
  }

  double getPriceInterval() {
    final priceRange = getMaxPrice() - getMinPrice();
    final interval = (priceRange / 5).roundToDouble();
    return interval > 0 ? interval : 100;
  }

  @override
  Widget build(BuildContext context) {
    final minPrice = getMinPrice();
    final maxPrice = getMaxPrice();
    final interval = getPriceInterval();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: karatColor.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('🇪🇬', style: TextStyle(fontSize: 24.sp)),
                      SizedBox(width: 8.w),
                      Text(
                        'Gold $selectedKarat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'EGP per gram',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isPriceUp
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isPriceUp
                        ? Colors.green.withOpacity(0.5)
                        : Colors.red.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPriceUp ? Icons.trending_up : Icons.trending_down,
                      color: isPriceUp ? Colors.green : Colors.red,
                      size: 16.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '${isPriceUp ? '+' : ''}$changePercentage%',
                      style: TextStyle(
                        color: isPriceUp ? Colors.green : Colors.red,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          HeightSpace(30),

          SizedBox(
            height: 280.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: interval,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.15),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),

                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35.h,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < 0 || value.toInt() >= days.length) {
                          return SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            days[value.toInt()],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: interval,
                      reservedSize: 60.w,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Text(
                            '${value.toInt()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),

                minX: 0,
                maxX: 6,
                minY: minPrice,
                maxY: maxPrice,

                lineBarsData: [
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [karatColor, karatColor.withOpacity(0.7)],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,

                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 7,
                          color: karatColor,
                          strokeWidth: 3,
                          strokeColor: Colors.white,
                        );
                      },
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          karatColor.withOpacity(0.4),
                          karatColor.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],

                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    tooltipPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(2)} EGP\n${days[spot.x.toInt()]}',
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  handleBuiltInTouches: true,
                  getTouchedSpotIndicator: (barData, spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: karatColor.withOpacity(0.5),
                          strokeWidth: 2,
                        ),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 8,
                              color: Colors.white,
                              strokeWidth: 3,
                              strokeColor: karatColor,
                            );
                          },
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
