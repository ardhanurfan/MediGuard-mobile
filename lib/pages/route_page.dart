import 'package:flutter/material.dart';
import 'package:mediguard/pages/navigation_page.dart';

import '../shared/theme.dart';
import '../widgets/destination_tile.dart';
import '../widgets/header.dart';
import '../widgets/logo_horizontal.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return ListView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          right: paddingHorizontal,
          left: paddingHorizontal,
          bottom: paddingHorizontal,
        ),
        children: [
          const LogoHorizontal(),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            padding: EdgeInsets.all(paddingHorizontal),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 0.5,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MG000000-01',
                  style: greyText.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                Text(
                  'Today\'s Mission 🚀',
                  style: primaryText.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(height: 32),
                const Column(
                  children: [
                    DestinationTile(
                      isDone: true,
                      isLast: false,
                    ),
                    DestinationTile(
                      isDone: true,
                      isLast: false,
                    ),
                    DestinationTile(
                      isDone: false,
                      isLast: false,
                    ),
                    DestinationTile(
                      isDone: false,
                      isLast: true,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  height: 36,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const NavigationPage(-6.893022, 107.606987),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google_maps_icon.png',
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "View on ",
                          style: whiteText.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                        Text(
                          "Google Maps",
                          style: whiteText.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          const Header(
            height: 0.3,
          ),
          body(),
        ],
      ),
    );
  }
}
