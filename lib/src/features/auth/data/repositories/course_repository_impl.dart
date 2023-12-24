import 'package:dartz/dartz.dart';
import 'package:store_house/core/errors/exception.dart';
import 'package:store_house/core/errors/failure.dart';
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:store_house/src/features/auth/data/models/user_model.dart';
import 'package:store_house/src/features/auth/domain/entities/user.dart';
import 'package:store_house/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthRemoteDataSource  _authRemoteDataSource=AuthDataSourceImpl();

  @override
  ResultFuture<UserModel> login(UserParams params)async {
    try {
      final result = await _authRemoteDataSource.reg(params);
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(message: 'تعذر تسجيل الدخول', statusCode: 400),
      );
    }
  }
}
