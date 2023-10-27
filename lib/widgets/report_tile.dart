import 'package:flutter/material.dart';

import '../shared/theme.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    super.key,
    required this.needs,
    required this.price,
    required this.onRemove,
    required this.onSee,
  });

  final String needs;
  final String price;
  final Function() onRemove;
  final Function() onSee;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                needs,
                style: primaryText.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Rp ',
                    style: greyText.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    price,
                    style: greyText.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.file_download_outlined,
                color: greyColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.remove_circle,
                color: redColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}
