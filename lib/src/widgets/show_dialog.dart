import 'dart:async';

import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_button.dart';

import '../theme/text_style.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog({
    Key? key,
    required this.message,
    required this.title,
    required this.onTapAction,
  }) : super(key: key);

  final String message;
  final String title;
  final Function() onTapAction;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool disableButton = true;
  int timeLimit = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counter();
  }

  void counter() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLimit -= 1;
        if (timeLimit == 0) {
          timer.cancel();
          disableButton = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.appBgColor,
      title: Directionality(
        textDirection: TextDirection.rtl, // Set the desired text direction
        child: Text(widget.title),
      ),
      titleTextStyle: AppTextStyle.titleLine,
      content: Column(
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.message,
              style: AppTextStyle.descriptionStyle,
            ),
          ),
        ],
      ),
      actions: [
        CustomButton(
            width: 100,
            onTap: () => Navigator.pop(context),
            title: 'إلغاء',
            textColor: AppColor.secondary,
            bgColor: AppColor.white),
        CustomButton(
            width: 100,
            title: ' موافق ${timeLimit == 0 ? '' : '($timeLimit)'} ',
            disableButton: disableButton,
            onTap: () {
              widget.onTapAction();
              Navigator.pop(context);
            }),
      ],
    );
  }
}
