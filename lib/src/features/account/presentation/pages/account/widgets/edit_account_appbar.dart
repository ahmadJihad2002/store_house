import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/build_svg_icon.dart';

class EditAccountAppBar extends StatelessWidget {
  const EditAccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        GestureDetector(
            onTap: () {
           Navigator.pop(context);
            },
            child:Icon(Icons.arrow_back_ios_outlined),
        )
      ],
    );
  }
}
