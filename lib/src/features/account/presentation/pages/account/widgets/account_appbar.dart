import 'package:flutter/material.dart';
import 'package:store_house/src/features/account/presentation/pages/edit_account.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/build_svg_icon.dart';

class AccountAppBar extends StatelessWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Account",
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAccount(userinfo: userinfo)))
            },
            child: const BuildSVGIcon(
              icon: 'assets/icons/edit.svg',
            ))
      ],
    );
  }
}
