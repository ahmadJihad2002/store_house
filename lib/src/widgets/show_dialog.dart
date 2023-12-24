import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
 import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_states.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';

class MyCustomDialog extends StatelessWidget {
  MyCustomDialog({super.key, required this.unit});

  final UnitModel unit;

  final _formKey = GlobalKey<FormState>();

  TextEditingController quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GoodsCubit cubit = GoodsCubit.get(context);

    return BlocConsumer<GoodsCubit, GoodsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: AppColor.appBgColor,
            title: const Text('تصدير'),
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    unit.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800),
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
                          unit.quantity.toString(),
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
                      if (value!.isEmpty) {}
                    },
                    keyboardType: TextInputType.number,
                    controller: quantity,
                    label: 'العدد',
                  )
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
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<TransactionCubit>()
                        .addIncomingUnit(int.parse(quantity.text), unit);

                    // cubit.addIncomingUnit(int.parse(quantity.text), unit);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }
}
