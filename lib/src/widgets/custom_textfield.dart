import 'package:flutter/material.dart';
import 'package:store_house/src/theme/app_color.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    Key? key,
    this.hint = "",
    this.prefix,
    this.suffix,
    this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.onTap,
    this.onChange,
    this.label,
    this.validate,
  }) : super(key: key);

  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final String? label;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String)? onChange;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const   TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
        Container(

          alignment: Alignment.center,
          height: 70,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.textBoxColor,
            border: Border.all(color: AppColor.textBoxColor),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.05),
                spreadRadius: .5,
                blurRadius: .5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            validator: validate,
            textDirection: TextDirection.rtl,
            keyboardType: keyboardType,
            readOnly: readOnly,
            controller: controller,
            onTap: onTap,
            onChanged: onChange,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              errorMaxLines: 1,

              errorStyle: TextStyle(color: Colors.red, fontSize: 8.0),
              prefixIcon: prefix,
              suffixIcon: suffix,
              border: InputBorder.none,
              hintText: hint,
              hintTextDirection: TextDirection.rtl,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
