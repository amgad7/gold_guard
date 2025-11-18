import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'package:gold_caurd_app/core/widgets/spacing_widgets.dart';

import '../services/gold_api_service.dart';
import '../data/gold_price_model.dart';
import '../widgets/currency_section_card.dart';
import '../widgets/loading_widgets.dart';
import '../widgets/price_change_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoldApiService _apiService = GoldApiService();

  GoldPriceModel? goldPriceUSD;
  GoldPriceModel? goldPriceEGP;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadGoldPrices();
  }

  Future<void> loadGoldPrices() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {

      final usdPrice = await _apiService.getGoldPrice('USD');


      final egpPrice = await _apiService.getGoldPrice('EGP');

      setState(() {
        goldPriceUSD = usdPrice;
        goldPriceEGP = egpPrice;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  String formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';

    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: loadGoldPrices,
          color: AppColors.primaryColor,
          backgroundColor: Colors.black,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: Colors.black,
                expandedHeight: 140.h,
                flexibleSpace: FlexibleSpaceBar(
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: AppColors.primaryColor,
                        size: 35.sp,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'GOLD GUARD',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    onPressed: loadGoldPrices,
                    icon: Icon(
                      Icons.refresh,
                      color: AppColors.primaryColor,
                      size: 28.sp,
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gold Prices Today',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HeightSpace(8),
                      Text(
                        'Live prices updated in real-time',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      HeightSpace(30),

                      if (isLoading)
                        LoadingWidget()
                      else if (errorMessage != null)
                        ErrorWidget(errorMessage!)
                      else
                        buildContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        if (goldPriceUSD != null) PriceChangeCard(model: goldPriceUSD!),

        HeightSpace(25),

        CurrencySectionCard(
          title: 'Prices in US Dollar (USD)',
          currency: 'USD',
          flag: '🇺🇸',
          priceModel: goldPriceUSD,
        ),

        HeightSpace(25),

        CurrencySectionCard(
          title: 'Prices in Egyptian Pound (EGP)',
          currency: 'EGP',
          flag: '🇪🇬',
          priceModel: goldPriceEGP,
        ),
        HeightSpace(20),
        if (goldPriceUSD?.timestamp != null)
          Text(
            'Last updated: ${formatTimestamp(goldPriceUSD!.timestamp!)}',
            style: TextStyle(
              color: AppColors.secondaryColor.withOpacity(0.6),
              fontSize: 12.sp,
            ),
          ),
      ],
    );
  }
}
