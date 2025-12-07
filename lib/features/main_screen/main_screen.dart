import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';

import '../gold_chart_screen/views/gold_chart_screen.dart';
import '../home/views/home_screen.dart';
import '../alerts/views/alerts_screen.dart'; // ← إضافة الـ Import

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    GoldChartScreen(),
    AlertsScreen(), // ← إضافة شاشة Alerts
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(
              color: AppColors.secondaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.secondaryColor.withOpacity(0.5),
          currentIndex: currentIndex,
          elevation: 0,
          selectedFontSize: 12.sp,
          unselectedFontSize: 10.sp,
          iconSize: 28.sp,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Icon(
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Icon(
                  currentIndex == 1
                      ? Icons.show_chart
                      : Icons.show_chart_outlined,
                ),
              ),
              label: "Chart",
            ),
            BottomNavigationBarItem( // ← إضافة Tab جديد
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Icon(
                  currentIndex == 2
                      ? Icons.notifications_active
                      : Icons.notifications_outlined,
                ),
              ),
              label: "Alerts",
            ),
          ],
        ),
      ),
    );
  }
}