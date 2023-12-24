import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/auth/domain/entities/user.dart';

class UserModel extends UserDomainModel {
  UserModel({
    required super.id,
    required super.name,
    required super.image,
    required super.email,
  });

  UserModel.fromMap(DataMap map)
      : this(
          id: map["id"] as String,
          name: map["name"] as String,
          image: map["image"] as String,
          email: map["email"] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
    };
  }
}
