import 'dart:convert';

import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel(
      {required super.id,
      required super.units,
      required super.date,
      required super.transactionType,
      required super.description,
      required super.timeStamp});

  TransactionModel.formJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            units: (jsonDecode(json["units"]) as List<dynamic>)
                .map((unitJson) => UnitModel.fromJson(unitJson, unitJson['id']))
                .toList(),
            date: json["date"],
            description: json["description"],
            transactionType: _parseTransactionType(json["transactionType"]),
            timeStamp: json['timeStamp']);

  factory TransactionModel.empty() => TransactionModel(
        id: '_empty.id',
        date: "_empty.date",
        transactionType: TransactionType.incoming,
        units: [],
        description: "_empty.description",
        timeStamp: '_empty.timeStamp',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'units': jsonEncode(units),
      'date': date,
      'transactionType': transactionType.toString(),
      'description': description,
      'timeStamp': timeStamp,
    };
  }

  static TransactionType _parseTransactionType(String value) {
    switch (value) {
      case 'TransactionType.incoming':
        return TransactionType.incoming;
      case 'TransactionType.outgoing':
        return TransactionType.outGoing;
      // Handle other enum values if needed
      default:
        return TransactionType.incoming; // Default value
    }
  }
}
