import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';

class AccountProfileBlock extends StatelessWidget {
  const AccountProfileBlock(
      {super.key, required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(image),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.05),
                spreadRadius: .5,
                blurRadius: .5,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
