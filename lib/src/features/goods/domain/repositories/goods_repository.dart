import 'dart:io';

import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/goods/data/models/transaction_model.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/usecases/edit_unit.dart';
import 'package:store_house/src/features/goods/pesentation/pages/edit_unit_details/edit_unit_details.dart';

abstract class GoodsRepository {
  const GoodsRepository();

  ResultFuture addNewUnit(UnitParams params);

  ResultFuture< List<UnitModel>> getAllGoods();

  ResultFuture<List<TransactionModel>> getAllTransactions();

  ResultFuture deleteUnit(UnitParams params);

  ResultFuture changingQuantityOfUnit(String unitID, int newQuantity);

  ResultFuture editUnit(UnitParams params,{File? oldImage});

  ResultFuture addTransactionDoc(TransactionParams params);
  ResultFuture deleteTransactionDoc(String transactionId);
}
