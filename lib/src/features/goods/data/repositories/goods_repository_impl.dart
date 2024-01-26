import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:store_house/core/errors/exception.dart';
import 'package:store_house/core/errors/failure.dart';
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/goods/data/data_sources/goods_data_Source.dart';
import 'package:store_house/src/features/goods/data/models/transaction_model.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';

class GoodsRepositoriesImp extends GoodsRepository {
  final GoodsRemoteDataSource _goodsRemoteDataSource =
      GoodsRemoteDataSourceImp();

  @override
  ResultFuture addNewUnit(UnitParams params) async {
    try {
      final result = await _goodsRemoteDataSource.addNewType(params);
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(message: 'failed to connect to server', statusCode: 400),
      );
    }
  }

  @override
  ResultFuture deleteUnit(UnitParams params, {File? oldImage}) async {
    try {
      final result = await _goodsRemoteDataSource.deleteUnit(params);
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(message: 'failed to connect to server', statusCode: 400),
      );
    }
  }

  @override
  ResultFuture editUnit(UnitParams params, {File? oldImage}) async {
    try {
      final result = await _goodsRemoteDataSource.editUnit(params);
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(message: 'failed to connect to server', statusCode: 400),
      );
    }
  }

  @override
  ResultFuture<List<UnitModel>>getAllGoods() async {
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

  @override
  ResultFuture addTransactionDoc(TransactionParams params) async {
    try {
      final result = await _goodsRemoteDataSource.addTransactionDoc(params);
      return Right(result);
    } on ServerException {
      return left(
        const ServerFailure(
            message: 'failed to connect to server', statusCode: 400),
      );
    }
  }

  @override
  ResultFuture<List<TransactionModel>> getAllTransactions() async {
    try {
      final result = await _goodsRemoteDataSource.getAllTransactions();
      return Right(result);
    } on ServerException {
      return left(
        const ServerFailure(
            message: 'failed to connect to server', statusCode: 400),
      );
    }
  }

  @override
  ResultFuture deleteTransactionDoc(String transactionId) async {
    try {
      final result =
          await _goodsRemoteDataSource.deleteTransactionDoc(transactionId);
      return Right(result);
    } on ServerException {
      return left(
        const ServerFailure(
            message: 'failed to connect to server', statusCode: 400),
      );
    }
  }
}
