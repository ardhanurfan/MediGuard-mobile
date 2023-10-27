import 'package:flutter/material.dart';
import 'package:mediguard/models/sensor_model.dart';
import 'package:mediguard/providers/sensor_provider.dart';
import 'package:mediguard/services/socket_service.dart';
import 'package:mediguard/widgets/custom_button.dart';
import 'package:mediguard/widgets/logo_horizontal.dart';
import 'package:provider/provider.dart';

import '../shared/theme.dart';
import '../widgets/header.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    _socketService.connectSocket();
    _socketService.socket.emit('subscribeToData', "MediGuard12345678");
    _socketService.socket.on('dataChanged', (data) {
      Provider.of<SensorProvider>(context, listen: false).setDataSensor =
          SensorModel.fromJson(data);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _socketService.socket.disconnect();
    _socketService.socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SensorProvider sensorProvider = Provider.of<SensorProvider>(context);
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
                  'Package Condition',
                  style: primaryText.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 28,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFFF3F2E0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: greenColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Safe',
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
                Text(
                  '${sensorProvider.temperature} °C',
                  style: primaryText.copyWith(
                    fontSize: 60,
                    fontWeight: bold,
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
                Text(
                  '${sensorProvider.altitude}%',
                  style: primaryText.copyWith(
                    fontSize: 60,
                    fontWeight: bold,
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
