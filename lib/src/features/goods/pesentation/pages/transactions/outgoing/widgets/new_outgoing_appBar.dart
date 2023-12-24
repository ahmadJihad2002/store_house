import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';

class NewOutgoingAppBar extends StatelessWidget {
  const NewOutgoingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "تصدير بضاعة",
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                 ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
