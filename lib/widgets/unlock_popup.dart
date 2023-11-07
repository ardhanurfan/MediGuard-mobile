import 'package:flutter/material.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

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
  @override
  Widget build(BuildContext context) {
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
              onWaitingProcess: () {
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isLoading = true;
                  });
                });
              },
              onFinish: () {
                Navigator.pop(context);
                setState(() {
                  isLoading = false;
                });
                CustomToast.showSuccess(message: "Enjoy your next trip");
              },
            )
          ],
        ));
  }
}
