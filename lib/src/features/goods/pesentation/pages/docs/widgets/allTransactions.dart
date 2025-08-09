import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/transactionCard.dart';

class AllTransactions extends StatelessWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactions = context.watch<TransactionCubit>().transactions;

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final e = transactions[index];
        return TransactionCard(doc: e);
      },
    );
  }
}
