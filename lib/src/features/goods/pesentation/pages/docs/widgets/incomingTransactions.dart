import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/transactionCard.dart';
import '../../../bloc/transaction_cubit/transaction_cuit.dart';

class IncomingTransactions extends StatelessWidget {
  const IncomingTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final incomingTransactions = context
        .watch<TransactionCubit>()
        .transactions
        .where((e) => e.transactionType == TransactionType.incoming)
        .toList();

    return ListView.builder(
      itemCount: incomingTransactions.length,
      itemBuilder: (context, index) {
        final e = incomingTransactions[index];
        return TransactionCard(doc: e);
      },
    );
  }
}
