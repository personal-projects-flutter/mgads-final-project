import 'package:final_project/test/core/domain/entity/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final String urImage;
  final int price;

  ProductModel({
    required this.id,
    required this.name,
    required this.urImage,
    required this.price,
  });

  ProductEntity toEntity() {
    return ProductEntity(id: id, name: name, urImage: urImage, price: price);
  }
}
