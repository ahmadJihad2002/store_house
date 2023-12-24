
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/auth/data/models/user_model.dart';
import 'package:store_house/src/features/auth/domain/entities/user.dart';
import 'package:store_house/src/features/course/domain/entities/course.dart';

abstract class AuthRepository {
  const AuthRepository();
  ResultFuture<UserModel> login(UserParams params);

}
