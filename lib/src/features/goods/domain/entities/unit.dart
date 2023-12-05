class Unit {
  late String id;
  late String name;
  late double price;
  late String image;
  late int quantity;
  late String description;

  Unit(
      {required this.price,
      required this.name,
      required this.id,
      required this.image,
      required this.quantity,
      required this.description});

  @override
  List<Object?> get props => [id, name, price, image, quantity, description];
}
