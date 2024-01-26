
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/account/data/models/user_model.dart';

abstract class AccountRepository {
  const AccountRepository();
  ResultFuture<UserModel> getUserInfo(String params);

}
