import 'package:flutter/material.dart';
import 'package:mediguard/models/unit_model.dart';
import 'package:mediguard/providers/unit_provider.dart';
import 'package:mediguard/services/socket_service.dart';
import 'package:mediguard/widgets/custom_button.dart';
import 'package:mediguard/widgets/logo_horizontal.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../shared/theme.dart';
import '../widgets/header.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  @override
  void initState() {
    if (mounted) {
      super.initState();
      final UnitProvider unitProvider =
          Provider.of<UnitProvider>(context, listen: false);
      SocketService.connectSocket();
      SocketService.socket
          .emit('subscribeToData', unitProvider.mediguard.unitId);
      SocketService.socket.on('dataChanged', (data) {
        Provider.of<UnitProvider>(context, listen: false).setDataSensor =
            UnitModel.fromJson(data);
      });
    }
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
      SocketService.socket.disconnect();
      SocketService.socket.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final UnitProvider unitProvider = Provider.of<UnitProvider>(context);
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
                  'Package Condition',
                  style: primaryText.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: unitProvider.mediguard.temperature >
                                unitProvider.deliveryCat.maxSuhu ||
                            unitProvider.mediguard.temperature <
                                unitProvider.deliveryCat.minSuhu
                        ? redColor.withOpacity(0.1)
                        : greenColor.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: unitProvider.mediguard.temperature >
                                    unitProvider.deliveryCat.maxSuhu ||
                                unitProvider.mediguard.temperature <
                                    unitProvider.deliveryCat.minSuhu
                            ? redColor
                            : greenColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        unitProvider.mediguard.temperature >
                                unitProvider.deliveryCat.maxSuhu
                            ? "Over Temperature"
                            : unitProvider.mediguard.temperature <
                                    unitProvider.deliveryCat.minSuhu
                                ? "Under Temperature"
                                : 'Safe',
                        style: greyText.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Suhu :',
                  style: greyText.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                Skeletonizer(
                  enabled: unitProvider.mediguard.temperature == 0,
                  child: Text(
                    '${unitProvider.mediguard.temperature.toStringAsFixed(2)} °C',
                    style: primaryText.copyWith(
                      fontSize: 60,
                      fontWeight: bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Kelembaban :',
                  style: greyText.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                Skeletonizer(
                  enabled: unitProvider.mediguard.humidity == 0,
                  child: Text(
                    '${unitProvider.mediguard.humidity} %',
                    style: primaryText.copyWith(
                      fontSize: 60,
                      fontWeight: bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Battery :',
                  style: greyText.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                Skeletonizer(
                  enabled: unitProvider.mediguard.battery == 0,
                  child: Text(
                    '${unitProvider.mediguard.battery} %',
                    style: primaryText.copyWith(
                      fontSize: 60,
                      fontWeight: bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
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
                Icon(
                  Icons.logout,
                  color: redColor,
                  size: 64,
                ),
                CustomButton(
                  marginTop: 32,
                  marginBottom: 16,
                  buttonColor: redColor,
                  buttonText: "Checkout",
                  onPressed: () {},
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
