import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styling/app_colors.dart';
import '../../../core/widgets/spacing_widgets.dart';
import '../data/gold_price_model.dart';
import 'cart_row_widgets.dart';

class CurrencySectionCard extends StatelessWidget {
  final String title;
  final String currency;
  final String flag;
  final GoldPriceModel? priceModel;

  const CurrencySectionCard({
    super.key,
    required this.title,
    required this.currency,
    required this.flag,
    required this.priceModel,
  });

  @override
  Widget build(BuildContext context) {
    if (priceModel == null || priceModel!.priceGram24k == null) {
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(flag, style: TextStyle(fontSize: 30.sp)),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          HeightSpace(20),
          Divider(color: AppColors.secondaryColor.withOpacity(0.2)),
          HeightSpace(20),

          KaratRow(
            karat: '24K',
            subtitle: 'Pure Gold',
            price: priceModel!.priceGram24k!,
            currency: currency,
            color: AppColors.primaryColor,
            isPremium: true,
          ),
          HeightSpace(15),

          KaratRow(
            karat: '21K',
            subtitle: 'Most Popular',
            price: priceModel!.price21k!,
            currency: currency,
            color: Colors.amber,
          ),
          HeightSpace(15),

          KaratRow(
            karat: '18K',
            subtitle: 'Standard Gold',
            price: priceModel!.price18k!,
            currency: currency,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
