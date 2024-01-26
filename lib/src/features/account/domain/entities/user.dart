import 'dart:io';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserDomainModel extends Equatable {
  UserDomainModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
   });

  final String id;
  final String name;
  final String image;
  final String email;

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];
}
