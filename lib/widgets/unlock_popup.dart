import 'package:flutter/material.dart';
import 'package:mediguard/services/unit_service.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../providers/unit_provider.dart';
import 'custom_toast.dart';

class UnlockPopUp extends StatefulWidget {
  const UnlockPopUp({
    super.key,
  });

  @override
  State<UnlockPopUp> createState() => _UnlockPopUpState();
}

class _UnlockPopUpState extends State<UnlockPopUp> {
  bool isLoading = false;

  lockOpen() async {
    final UnitProvider unitProvider =
        Provider.of<UnitProvider>(context, listen: false);
    await UnitService()
        .lockMediGuard(unitId: unitProvider.mediguard.unitId, value: true);
  }

  @override
  void initState() {
    if (mounted) {
      super.initState();
      lockOpen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final UnitProvider unitProvider = Provider.of<UnitProvider>(context);

    return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        title: Text(
          "Successfully 🎉\nUnlock MediGuard\n",
          style: primaryText.copyWith(fontSize: 20, fontWeight: bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 150,
              color: greenColor,
            ),
            const SizedBox(height: 36),
            Text(
              "Unload your packages",
              style: primaryText.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "MediGuard will be autolock after you swipe next trip",
              style: redText.copyWith(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            SwipeableButtonView(
              buttonText: 'Next Trip',
              buttonWidget: Icon(
                Icons.arrow_forward_ios_rounded,
                color: primaryColor,
              ),
              activeColor: primaryColor,
              isFinished: isLoading,
              onWaitingProcess: () async {
                final navigator = Navigator.of(context);
                setState(() {
                  isLoading = true;
                });
                try {
                  if (await UnitService().nextDestination(
                          unitId: unitProvider.mediguard.unitId) &&
                      await UnitService().lockMediGuard(
                          unitId: unitProvider.mediguard.unitId,
                          value: false)) {
                    if (await unitProvider.getUnitById(
                        unitId: unitProvider.mediguard.unitId)) {
                      CustomToast.showSuccess(message: "Enjoy your next trip");
                      navigator.pop();
                    } else {
                      CustomToast.showSuccess(message: "Trip finished");
                      navigator.pushNamedAndRemoveUntil(
                          '/start', (route) => false);
                    }
                  }
                } catch (e) {
                  print(e);
                  CustomToast.showFailed(message: "Next trip failed");
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              onFinish: () {},
            )
          ],
        ));
  }
}
