import 'package:flutter/material.dart';
import 'package:mediguard/pages/account_page.dart';
import 'package:mediguard/pages/monitor_page.dart';
import 'package:mediguard/pages/report_page.dart';
import 'package:mediguard/pages/route_page.dart';

import '../shared/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget customButtonNav() {
      return BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 32,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            if (value == 2) {
              return;
            }
            currentIndex = value;
          });
        },
        selectedLabelStyle: seccondaryText.copyWith(
          fontSize: 12,
          fontWeight: regular,
          height: 2,
        ),
        unselectedLabelStyle: disableText.copyWith(
          fontSize: 12,
          fontWeight: regular,
          height: 2,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              child: Image.asset(
                'assets/monitor_icon.png',
                color: currentIndex == 0 ? secondaryColor : disableColor,
                width: 21,
              ),
            ),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              child: Image.asset(
                'assets/route_icon.png',
                color: currentIndex == 1 ? secondaryColor : disableColor,
                width: 20,
              ),
            ),
            label: 'Route',
          ),
          const BottomNavigationBarItem(
            icon: Visibility(
              visible: false,
              child: SizedBox(),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              child: Image.asset(
                'assets/report_icon.png',
                color: currentIndex == 3 ? secondaryColor : disableColor,
                width: 20,
              ),
            ),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              child: Image.asset(
                'assets/account_icon.png',
                color: currentIndex == 4 ? secondaryColor : disableColor,
                width: 18,
              ),
            ),
            label: 'Account',
          ),
        ],
      );
    }

    Widget cartButton() {
      return Theme(
        data: ThemeData(useMaterial3: false),
        child: SizedBox(
          height: 72,
          width: 72,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: primaryColor,
              child: Image.asset(
                'assets/scanner_icon.png',
                width: 28,
              ),
            ),
          ),
        ),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return const MonitorPage();
        case 1:
          return const RoutePage();
        case 3:
          return const ReportPage();
        case 4:
          return const AccountPage();
        default:
          return const MonitorPage();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customButtonNav(),
      body: body(),
    );
  }
}
