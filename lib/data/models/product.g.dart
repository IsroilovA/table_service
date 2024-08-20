// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imagePath: json['imagePath'] as String? ??
          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.minglewoodharborside.com%2Fmenu&psig=AOvVaw0wrOSF4WdDiJ22e4hWGDYU&ust=1724064199838000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLjOpeSt_ocDFQAAAAAdAAAAABAJ",
      id: json['id'],
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'imagePath': instance.imagePath,
    };
