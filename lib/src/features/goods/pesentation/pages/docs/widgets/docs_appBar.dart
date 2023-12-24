import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';

class DocsAppbar extends StatelessWidget {
  const DocsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColor.mainColor,
                )),
            const Text(
              "مستندات",
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          '',
          style: TextStyle(fontSize: 10, color: AppColor.darker),
        )
      ],
    );
  }
}
