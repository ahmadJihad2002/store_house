import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_house/src/theme/app_color.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.icon,
    this.onTap,
    this.color = Colors.grey,
    this.activeColor = AppColor.primary,
    this.isActive = false,
    this.isNotified = false,
    this.goodsNumber,
  });

  final String icon;
  final Color color;
  final Color activeColor;
  final bool isNotified;
  final bool isActive;
  final GestureTapCallback? onTap;
  final int? goodsNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.bottomBarColor,
          // boxShadow: [
          //   if (isActive)
          //     BoxShadow(
          //       color: AppColor.shadowColor.withOpacity(0.1),
          //       spreadRadius: 2,
          //       blurRadius: 2,
          //       offset: const Offset(0, 0), // changes position of shadow
          //     ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              icon,
              width: 100,
              height: 140,
            ),
            Text(
              '${goodsNumber ?? ''}',
              style: const TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
