import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'package:gold_caurd_app/core/widgets/spacing_widgets.dart';

import '../../home/services/gold_api_service.dart';
import '../data/gold_history_model.dart';
import '../widgets/chart_header_widget.dart';
import '../widgets/karat_selector_widget.dart';
import '../widgets/gold_chart_egypt_widget.dart';
import '../widgets/chart_statistics_section.dart';
import '../widgets/chart_info_note_widget.dart';
import '../widgets/chart_loading_widget.dart';
import '../widgets/chart_error_widget.dart';

class GoldChartScreen extends StatefulWidget {
  const GoldChartScreen({super.key});

  @override
  State<GoldChartScreen> createState() => _GoldChartScreenState();
}

class _GoldChartScreenState extends State<GoldChartScreen> {
  final GoldApiService _apiService = GoldApiService();

  String selectedKarat = '24K';
  bool isLoading = true;
  String? errorMessage;

  List<GoldHistoryModel> historyData = [];
  List<FlSpot> chartData = [];

  final List<String> days = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  @override
  void initState() {
    super.initState();
    loadHistoryData();
  }

  Future<void> loadHistoryData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _apiService.getGoldPriceHistory('EGP', 7);

      setState(() {
        historyData = data;
        updateChartData();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void updateChartData() {
    chartData = historyData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      double price;
      switch (selectedKarat) {
        case '21K':
          price = item.price21k;
          break;
        case '18K':
          price = item.price18k;
          break;
        default:
          price = item.price24k;
      }

      return FlSpot(index.toDouble(), price);
    }).toList();
  }

  Color getKaratColor() {
    switch (selectedKarat) {
      case '21K':
        return Colors.amber;
      case '18K':
        return Colors.orange;
      default:
        return AppColors.primaryColor;
    }
  }

  String getHighestPrice() {
    if (chartData.isEmpty) return '0.00';
    return chartData
        .map((e) => e.y)
        .reduce((a, b) => a > b ? a : b)
        .toStringAsFixed(2);
  }

  String getLowestPrice() {
    if (chartData.isEmpty) return '0.00';
    return chartData
        .map((e) => e.y)
        .reduce((a, b) => a < b ? a : b)
        .toStringAsFixed(2);
  }

  String getAveragePrice() {
    if (chartData.isEmpty) return '0.00';
    final sum = chartData.map((e) => e.y).reduce((a, b) => a + b);
    return (sum / chartData.length).toStringAsFixed(2);
  }

  String getPriceChange() {
    if (chartData.length < 2) return '0.00';
    final change = chartData.last.y - chartData.first.y;
    return change.toStringAsFixed(2);
  }

  bool isPriceUp() {
    if (chartData.length < 2) return true;
    return chartData.last.y > chartData.first.y;
  }

  String getChangePercentage() {
    if (chartData.length < 2) return '0.00';
    final change =
        ((chartData.last.y - chartData.first.y) / chartData.first.y) * 100;
    return change.toStringAsFixed(2);
  }

  void onKaratChanged(String karat) {
    setState(() {
      selectedKarat = karat;
      updateChartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadHistoryData,
          color: AppColors.primaryColor,
          backgroundColor: Colors.black,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChartHeaderWidget(),
                  HeightSpace(30),

                  KaratSelectorWidget(
                    selectedKarat: selectedKarat,
                    onKaratChanged: onKaratChanged,
                  ),
                  HeightSpace(25),

                  buildMainContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMainContent() {
    if (isLoading) {
      return ChartLoadingWidget();
    }

    if (errorMessage != null) {
      return ChartErrorWidget(
        errorMessage: errorMessage,
        onRetry: loadHistoryData,
      );
    }

    return Column(
      children: [
        GoldChartEgyptWidget(
          selectedKarat: selectedKarat,
          chartData: chartData,
          days: days,
          isPriceUp: isPriceUp(),
          changePercentage: getChangePercentage(),
          karatColor: getKaratColor(),
        ),
        HeightSpace(25),

        ChartStatisticsSection(
          highestPrice: getHighestPrice(),
          lowestPrice: getLowestPrice(),
          averagePrice: getAveragePrice(),
          priceChange: getPriceChange(),
          isPriceUp: isPriceUp(),
        ),
        HeightSpace(25),

        ChartInfoNoteWidget(),
      ],
    );
  }
}
