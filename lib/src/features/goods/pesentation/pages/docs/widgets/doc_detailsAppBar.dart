import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';

class DocsDetailsAppbar extends StatelessWidget {
  const DocsDetailsAppbar({super.key});

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
              "تفاصيل المستند",
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
