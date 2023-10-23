import 'package:flutter/cupertino.dart';

import '../shared/theme.dart';

class LogoHorizontal extends StatelessWidget {
  const LogoHorizontal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logo.png",
          width: 36,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 8),
        Text(
          'Medi',
          style: whiteText.copyWith(
            fontSize: 24,
            fontWeight: regular,
          ),
        ),
        Text(
          'Guard',
          style: whiteText.copyWith(
            fontSize: 24,
            fontWeight: bold,
          ),
        )
      ],
    );
  }
}
