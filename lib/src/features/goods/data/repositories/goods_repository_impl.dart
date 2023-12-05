import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_house/core/errors/exception.dart';
import 'package:store_house/core/errors/failure.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/goods/data/data_sources/goods_data_Source.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';
import 'package:uuid/uuid.dart';

class GoodsRepositoriesImp extends GoodsRepository {
  final GoodsRemoteDataSource _goodsRemoteDataSource =
      GoodsRemoteDataSourceImp();

  @override
  ResultFuture addNewUnit(
      {required String name,
      required String description,
      required File image,
      required double price,
      required int quantity}) async {
    try {
      final result = await _goodsRemoteDataSource.addNewType(
          id: name,
          name: name,
          description: description,
          image: image,
          price: price,
          quantity: quantity);
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(message: 'failed to connect to server', statusCode: 400),
      );
    }
  }

  @override
  ResultFuture decreaseUnit() {
    // TODO: implement decreaseUnit
    throw UnimplementedError();
  }

  @override
  ResultFuture deleteUnit() {
    // TODO: implement deleteUnit
    throw UnimplementedError();
  }

  @override
  ResultFuture editUnit() {
    // TODO: implement editUnit
    throw UnimplementedError();
  }

  // @override
  // ResultFuture<List<Unit>> getAllGoods() {
  //   // TODO: implement getAllGoods
  //   throw UnimplementedError();
  // }

  @override
  ResultFuture increaseUnit() {
    // TODO: implement increaseUnit
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<UnitModel>> getAllGoods() async {
    try {
      final result = await _goodsRemoteDataSource.getAllGoods();
      return Right(result);
    } on ServerException {
      return left(
        const ServerFailure(
            message: 'failed to connect to server', statusCode: 400),
      );
    }
  }

  @override
  ResultFuture changingQuantityOfUnit(String unitID, int newQuantity) async {
    try {
      final result = await _goodsRemoteDataSource.changingQuantityOfUnit(
          unitID, newQuantity);
      return Right(result);
    } on ServerException {
      return left(
        const ServerFailure(
            message: 'failed to connect to server', statusCode: 400),
      );
    }
  }
}
