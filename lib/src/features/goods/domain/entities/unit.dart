import 'dart:io';

class Unit {
  late String id;
  late String name;
  late int price;
  late String image;
  late int quantity;
  late String description;
  late int? threshold;

  Unit(
      {required this.price,
      required this.name,
      required this.id,
      required this.image,
      required this.quantity,
      required this.description,
      this.threshold});

  @override
  List<Object?> get props => [id, name, price, image, quantity, description];
}

class UnitParams {
  final String? id;
  final String name;
  final int quantity;
  final String description;
  final File image;
  final int price;
  int? threshold;

  UnitParams({
    this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.image,
    required this.price,
    this.threshold,
  });
}
