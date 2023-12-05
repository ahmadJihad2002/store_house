import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import 'package:store_house/src/theme/app_color.dart';

class SettingBox extends StatelessWidget {
  const SettingBox({
    Key? key,
    required this.title,
    required this.icon,
    this.color = AppColor.darker,
  }) : super(key: key);

  final String title;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            width: 22,
            height: 22,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
