import 'dart:io';

import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';

abstract class GoodsRepository {
  const GoodsRepository();

  ResultFuture addNewUnit(
      {required String name,
      required String description,
      required File image,
      required double price,
      required int quantity});

  ResultFuture increaseUnit();

  ResultFuture <List<UnitModel>> getAllGoods();

  ResultFuture decreaseUnit();
  ResultFuture changingQuantityOfUnit(String unitID, int newQuantity);

  ResultFuture deleteUnit();

  ResultFuture editUnit();


// ResultFuture<List<Unit>> getAllGoods();
}
