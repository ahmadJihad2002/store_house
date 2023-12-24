import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_house/src/theme/app_color.dart';

class BuildSVGIcon extends StatelessWidget {
  const BuildSVGIcon({
    super.key,
    required this.icon,
    this.color = Colors.black,
    this.isActive = false,
    this.activeColor = AppColor.primary,
    this.width = 23,
    this.height = 23,
  });

  final String icon;
  final Color color;
  final bool isActive;
  final Color activeColor;
  final double width;
  final double height;

  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      colorFilter:
          ColorFilter.mode(isActive ? activeColor : color, BlendMode.srcIn),
      width: width,
      height: height,
    );
  }
}
