import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/cupertino.dart';

import '../shared/theme.dart';

class DestinationTile extends StatelessWidget {
  const DestinationTile({
    super.key,
    required this.isDone,
    required this.isLast,
  });

  final bool isDone;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: isDone ? disableColor : primaryColor,
              ),
              child: Center(
                child: Text(
                  '1',
                  style: whiteText.copyWith(
                    fontSize: 20,
                    fontWeight: semibold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apotek Jaya Abadi Nusantara',
                    style: (isDone ? disableText : primaryText).copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    ),
                  ),
                  Text(
                    'Jln. Ajisutomo No. 21aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                    style: (isDone ? disableText : primaryText).copyWith(
                      fontSize: 10,
                      fontWeight: regular,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Visibility(
          visible: !isLast,
          child: SizedBox(
            width: 47,
            child: Center(
              child: DottedDashedLine(
                dashColor: isDone ? disableColor : primaryColor,
                height: 28,
                width: 0,
                axis: Axis.vertical,
                strokeWidth: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
