import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
 import 'package:store_house/src/features/auth/data/repositories/auth_repository_impl.dart';
 import 'package:store_house/src/features/auth/domain/entities/user.dart';
import 'package:store_house/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCaseWithParams<String,UserParams> {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  @override
  ResultFuture<String>  call(UserParams params) async {
    return await _authRepository.login(params);
  }
}
