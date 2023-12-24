import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/transactions/incoming/widgets/incoming_units.dart';
import 'package:store_house/src/features/goods/pesentation/pages/transactions/widgets/list_of_selected_units.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';

import '../../../../../../../core/services/util.dart';
import 'widgets/new_incoming_appBar.dart';

class NewIncomingPage extends StatelessWidget {
  NewIncomingPage({Key? key}) : super(key: key);
  TextEditingController description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TransactionCubit cubit = TransactionCubit.get(context);
    return BlocConsumer<TransactionCubit, TransactionStates>(
        listener: (context, state) {
      if (state is AppAddIncomingGoodsSuccessState) {
        context.read<GoodsCubit>().getAllGoods();
        context.read<TransactionCubit>().getAllTransactions();

        // Navigator.pop(context);
        showToast(text: 'تم الضافة بنجاح', state: ToastStates.success);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  context.read<GoodsCubit>().addTransactionMode=false;

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: const NewIncomingAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                addAutomaticKeepAlives: false,
                (context, index) => _buildBody(cubit, context, state),
                childCount: 1,
              ),
            )
          ],
        ),
      );
    });
  }

  _buildBody(
      TransactionCubit cubit, BuildContext context, TransactionStates state) {
    TextEditingController dateController =
        TextEditingController(text: cubit.selectedDate);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextBox(
              label: "التاريخ",
              readOnly: true,
              keyboardType: TextInputType.datetime,
              controller: dateController,
              onTap: () => cubit.selectDate(context),
            ),
            const SizedBox(height: 30),
            CustomTextBox(
              controller: description,
              label: 'تعليق',
            ),
            const SizedBox(height: 30),
            ListOfUnits(units:cubit.incomingGoods),
            // IncomingUnits(),
            const SizedBox(height: 30),
            ConditionalBuilder(
              condition: state is AppAddIncomingGoodsLoadingState,
              builder: (context) => const CustomProgressIndicator(),
              fallback: (context) => CustomButton(
                  radius: 10,
                  title: "إضافة",
                  onTap: () async {
                    context.read<GoodsCubit>().addTransactionMode=false;

                    await cubit.sendTransaction(
                      date: cubit.selectedDate.toString(),
                      description: description.text,
                      transactionType: TransactionType.incoming,
                      timeStamp:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                    );
                    print('done sending ');

                    cubit.changeQuantityOfUnit(context);
                    print('done sending 2');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
