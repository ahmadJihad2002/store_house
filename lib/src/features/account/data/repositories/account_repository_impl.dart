import 'package:dartz/dartz.dart';
import 'package:store_house/core/errors/exception.dart';
import 'package:store_house/core/errors/failure.dart';
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/account/data/data_sources/account_remote_data_source.dart';
import 'package:store_house/src/features/account/data/models/user_model.dart';
import 'package:store_house/src/features/account/domain/repositories/account_repository.dart';
class AccountRepositoryImpl extends AccountRepository {

  final AccountRemoteDataSource  _accountRemoteDataSource=AccountRemoteDataSourceImpl();


  @override
  ResultFuture<UserModel> getUserInfo(String params) async{
    try {
      final result = await _accountRemoteDataSource.getUserInfo(params);
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(message: 'تعذر الحصول على معلومات المستخدم', statusCode: 400),
      );
    }
  }
}
