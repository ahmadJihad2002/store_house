import 'package:store_house/src/features/goods/data/models/unit_model.dart';

enum TransactionType { incoming, outGoing }

class Transaction {
  late String id;
  late String date;
  late List<UnitModel> units;
  late TransactionType transactionType;
  late String description;
  late String timeStamp;

  Transaction(
      {required this.id,
      required this.units,
      required this.date,
      required this.transactionType,
      required this.description,
      required this.timeStamp});

  @override
  List<Object?> get props => [id, date, units, transactionType, description];
}

class TransactionParams {
  final String date;
  final List<UnitModel> units;
  final TransactionType transactionType;
  final String description;
  final String timeStamp;

  TransactionParams({
    required this.date,
    required this.units,
    required this.description,
    required this.transactionType,
    required this.timeStamp,
  });
}
