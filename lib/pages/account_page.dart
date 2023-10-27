import 'package:flutter/material.dart';

import '../shared/theme.dart';
import '../widgets/account_menu_tile.dart';
import '../widgets/header.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
          Text(
            'Account',
            style: whiteText.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: 32,
            ),
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
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundColor: primaryColor,
                      child: const CircleAvatar(
                        radius: 50,
                        foregroundImage: AssetImage('assets/astuti.png'),
                        backgroundImage: NetworkImage(
                            'https://ui-avatars.com/api/?name=Astuti+&color=33BDFE&background=EBF4FF'),
                      ),
                    ),
                    FloatingActionButton.small(
                      heroTag: UniqueKey(),
                      onPressed: () {},
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFF6551E0),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Astuti',
                  style: greyText.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Driver',
                  style: greyText.copyWith(
                    fontSize: 10,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF569FED).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/profile_icon.png',
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Profile',
                          style: primaryText.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Edit all the basic profile information associated with your profile',
                          style: greyText.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          AccountMenuTile(
            path: 'assets/notification_icon.png',
            title: 'Notifications',
            onTap: () {},
          ),
          AccountMenuTile(
            path: 'assets/history_icon.png',
            title: 'Trip History',
            onTap: () {},
          ),
          AccountMenuTile(
            path: 'assets/help_icon.png',
            title: 'Get Help',
            onTap: () {},
          ),
          AccountMenuTile(
            path: 'assets/about_us_icon.png',
            title: 'About Us',
            onTap: () {},
          ),
          AccountMenuTile(
            path: 'assets/sign_out_icon.png',
            title: 'Sign Out',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign-in', (route) => false);
            },
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
