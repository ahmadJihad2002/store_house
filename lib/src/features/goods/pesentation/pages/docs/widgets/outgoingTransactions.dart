import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/transactionCard.dart';

import '../../../../domain/entities/transaction.dart';
import '../../../bloc/transaction_cubit/transaction_cuit.dart';

class OutgoingTransactions extends StatelessWidget {
  const OutgoingTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: context.read<TransactionCubit>().transactions
          .where((e) => e.transactionType == TransactionType.outGoing)
          .map((e) => TransactionCard(
        date: e.date,
        transactionType: e.transactionType,
        description: e.description,
        units: e.units,
      ))
          .toList(),
    );
  }
}
