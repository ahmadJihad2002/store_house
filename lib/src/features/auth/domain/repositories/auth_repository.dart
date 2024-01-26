
 import 'package:store_house/core/utils/typedef.dart';
 import 'package:store_house/src/features/auth/domain/entities/user.dart';


abstract class AuthRepository {
  const AuthRepository();
  ResultFuture<String> login( UserParams params);

}
