import 'package:flutter/material.dart';
import 'package:mediguard/widgets/add_report_popup.dart';

import '../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/header.dart';
import '../widgets/logo_horizontal.dart';
import '../widgets/report_tile.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController reportValueController = TextEditingController();

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
                  'Report Management',
                  style: primaryText.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please report your expenses for fuel\npurchases, parking, and other costs.',
                  style: greyText.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ReportTile(
                      needs: 'Gas Expenses',
                      price: '12.000',
                      onRemove: () {},
                      onSee: () {},
                    ),
                    ReportTile(
                      needs: 'Parks',
                      price: '20.000',
                      onRemove: () {},
                      onSee: () {},
                    ),
                  ],
                ),
                CustomButton(
                  marginTop: 20,
                  buttonColor: primaryColor,
                  buttonText: "Add",
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddReportPopUp(
                          onAdd: () {},
                          controller: reportValueController,
                        );
                      },
                    );
                  },
                  textStyle: whiteText,
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
