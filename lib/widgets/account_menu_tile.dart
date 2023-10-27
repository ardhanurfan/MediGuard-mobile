import 'package:flutter/material.dart';

import '../shared/theme.dart';

class AccountMenuTile extends StatelessWidget {
  const AccountMenuTile({
    required this.title,
    required this.path,
    required this.onTap,
    super.key,
  });

  final String title;
  final String path;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              path,
              height: 16,
              width: 16,
              color: title == "Sign Out" ? redColor : greyColor,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: (title == "Sign Out" ? redText : greyText).copyWith(
                fontSize: 12,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
