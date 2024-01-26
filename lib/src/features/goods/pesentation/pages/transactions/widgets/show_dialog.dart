import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';

class MyCustomDialog extends StatefulWidget {
  MyCustomDialog(
      {super.key, required this.unit, required this.transactionType});

  final UnitModel unit;
  final TransactionType transactionType;

  @override
  State<MyCustomDialog> createState() => _MyCustomDialogState();
}

class _MyCustomDialogState extends State<MyCustomDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController quantity = TextEditingController();

  String? error;
  bool disableButton = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.appBgColor,
      title: Text(widget.transactionType == TransactionType.outGoing
          ? 'تصدير'
          : 'استيراد'),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.unit.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: [
                const Text(
                  'متوفر في المخزون',
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                  child: Text(
                    widget.unit.quantity.toString(),
                    style: const TextStyle(
                        fontSize: 10, color: AppColor.quantityColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextBox(
              validate: (value) {
                if (value!.isEmpty) {
                  return 'ادخل العدد';
                }
              },
              onChange: (string) {
                if (widget.transactionType == TransactionType.outGoing) {
                  if (int.parse(string) > widget.unit.quantity) {
                    setState(() {
                      error = 'العدد اكبر من الكمية المتوفرة في المخزون';
                      disableButton = true;
                    });
                  } else {
                    setState(() {
                      error = null;
                      disableButton = false;
                    });
                  }
                }
              },
              keyboardType: TextInputType.number,
              controller: quantity,
              label: 'العدد',
            ),
            if (error != null) ...[
              Text(
                error!,
                style: const TextStyle(
                    fontSize: 8,
                    color: AppColor.primary,
                    fontWeight: FontWeight.w100),
              )
            ],
          ],
        ),
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
          title: 'إدخال',
          disableButton: disableButton,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              context
                  .read<TransactionCubit>()
                  .addUnitToTransactions(int.parse(quantity.text), widget.unit);



              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
