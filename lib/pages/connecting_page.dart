import 'package:flutter/material.dart';
import 'package:mediguard/providers/unit_provider.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_toast.dart';

class ConnectiongPage extends StatefulWidget {
  const ConnectiongPage({super.key, required this.value});
  final String value;

  @override
  State<ConnectiongPage> createState() => _ConnectiongPageState();
}

class _ConnectiongPageState extends State<ConnectiongPage> {
  @override
  void initState() {
    super.initState();
    handleStart(unitId: widget.value);
  }

  handleStart({required String unitId}) async {
    final UnitProvider unitProvider =
        Provider.of<UnitProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    try {
      if (await unitProvider.connect(unitId: "MediGuard12345678")) {
        CustomToast.showSuccess(message: "Connect to MediGuard success");
        navigator.pushNamedAndRemoveUntil('/main', (route) => false);
      } else {
        CustomToast.showFailed(message: "Failed connect to MediGuard");
        navigator.pushNamedAndRemoveUntil('/start', (route) => false);
      }
    } catch (e) {
      CustomToast.showFailed(message: e.toString());
      navigator.pushNamedAndRemoveUntil('/start', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Medi',
                style: whiteText.copyWith(
                  fontSize: 36,
                  fontWeight: regular,
                ),
              ),
              Text(
                'Guard',
                style: whiteText.copyWith(
                  fontSize: 36,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [orangeColor, yellowColor]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connecting...',
                  style: whiteText.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
