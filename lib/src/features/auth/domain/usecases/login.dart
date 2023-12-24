import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/auth/data/models/user_model.dart';
 import 'package:store_house/src/features/auth/data/repositories/course_repository_impl.dart';
import 'package:store_house/src/features/auth/domain/entities/user.dart';
import 'package:store_house/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCaseWithParams<UserModel,UserParams> {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  @override
  ResultFuture<UserModel>  call(UserParams params) async {
    return await _authRepository.login(params);
  }
}
