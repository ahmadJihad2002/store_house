import 'dart:convert';

import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/course/domain/entities/course.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';

// ignore: must_be_immutable
class UnitModel extends Unit {
  UnitModel({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.price,
    required super.quantity,
  });

  UnitModel.fromJson(Map<String, dynamic> json, String id)
      : this(
            id: id,
            name: json["name"],
            description: json["description"],
            image: json["image"],
            price: json["price"],
            quantity: json["quantity"]);

  factory UnitModel.empty() => UnitModel(
        id: '_empty.id',
        name: "_empty.name",
        price: 0.0,
        image: "_empty.image",
        description: "_empty.description",
        quantity: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'quantity': quantity,
    };
  }
}
