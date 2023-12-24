import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';

import '../../../../../../../core/utils/app_navigate.dart';
import '../../../../../../widgets/build_svg_icon.dart';
import '../../add_type/add_type.dart';

class GoodsAppbar extends StatelessWidget {
  const GoodsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColor.mainColor,
            )),
        const Expanded(
          child: Text(
            "goods",
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: GestureDetector(
            onTap: () => AppNavigator.to(context, AddNewType()),
            child: const Column(
              children: [
                BuildSVGIcon(
                  color: AppColor.primary,
                  height: 30,
                  width: 30,
                  icon: 'assets/icons/add.svg',
                ),
                Text(
                  'إضافة صنف جديد',
                  style: TextStyle(color: AppColor.darker, fontSize: 8),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
