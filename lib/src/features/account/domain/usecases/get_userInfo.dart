import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/account/data/models/user_model.dart';
import 'package:store_house/src/features/account/data/repositories/account_repository_impl.dart';
import 'package:store_house/src/features/account/domain/repositories/account_repository.dart';

class GetUserInfoUseCase extends UseCaseWithParams<UserModel,String> {
  final AccountRepository _accountRepository = AccountRepositoryImpl();

  @override
  ResultFuture<UserModel>  call(String params) async {
    return await _accountRepository.getUserInfo(params);
  }
}
