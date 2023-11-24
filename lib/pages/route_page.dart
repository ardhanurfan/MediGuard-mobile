import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mediguard/models/transaction_model.dart';
import 'package:mediguard/pages/navigation_page.dart';
import 'package:mediguard/services/unit_service.dart';
import 'package:mediguard/services/token_service.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../providers/unit_provider.dart';
import '../shared/theme.dart';
import '../widgets/custom_toast.dart';
import '../widgets/destination_tile.dart';
import '../widgets/header.dart';
import '../widgets/logo_horizontal.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  bool isLoading = false;
  List<TransactionModel> dataTransaction = [];
  List<LatLng> point = [];
  Location location = Location();

  @override
  void initState() {
    super.initState();
    handleStart();
  }

  handleStart() async {
    setState(() {
      isLoading = true;
    });
    try {
      String? unitId = await TokenService.getTokenPreference("unit");
      if (unitId != null) {
        dataTransaction =
            await UnitService().getTransactionById(unitId: unitId);
        point = dataTransaction
            .map((e) => LatLng(e.address.latitude, e.address.longitude))
            .toList();
        LocationData currentPosition = await location.getLocation();
        point.insert(
            0, LatLng(currentPosition.altitude!, currentPosition.longitude!));
      }
    } catch (e) {
      CustomToast.showFailed(message: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UnitProvider unitProvider = Provider.of<UnitProvider>(context);
    int i = 0;

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
                  unitProvider.mediguard.unitId,
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
                Column(
                  children: isLoading
                      ? List.generate(
                          3,
                          (index) => Skeletonizer(
                            enabled: isLoading,
                            child: const ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              title: Text('The title goes here'),
                              subtitle: Text('Subtitle here eeexxxxxxxxxxxxx'),
                              leading: Icon(Icons.ac_unit, size: 50),
                            ),
                          ),
                        )
                      : dataTransaction.map(
                          (transaction) {
                            i++;
                            return DestinationTile(
                              isDone: transaction.orderNum !=
                                  unitProvider.mediguard.currentTransaction,
                              isLast: dataTransaction.length == i,
                              address: transaction.address.alamat,
                              no: i.toString(),
                              title: transaction.address.channel,
                            );
                          },
                        ).toList(),
                ),
                Skeletonizer(
                  enabled: isLoading,
                  containersColor: Colors.grey.shade200,
                  child: Container(
                    margin: const EdgeInsets.only(top: 32),
                    height: 36,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationPage(
                              listPoint: point,
                            ),
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
