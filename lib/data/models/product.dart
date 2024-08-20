import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

const uuid = Uuid();

@JsonSerializable()
class Product {
  String id;
  String name;
  double price;
  String imagePath;

  Product({
    required this.name,
    required this.price,
    this.imagePath =
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.minglewoodharborside.com%2Fmenu&psig=AOvVaw0wrOSF4WdDiJ22e4hWGDYU&ust=1724064199838000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLjOpeSt_ocDFQAAAAAdAAAAABAJ",
    id,
  }) : id = id ?? uuid.v4;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
