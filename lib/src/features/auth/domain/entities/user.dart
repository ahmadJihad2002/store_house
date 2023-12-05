import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserDomainModel extends Equatable {
  UserDomainModel({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];
}
