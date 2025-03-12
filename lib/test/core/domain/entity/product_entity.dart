import 'package:final_project/test/home/presentation/model/product_model.dart';

final class ProductEntity {
  final String id;
  final String name;
  final String urImage;
  final int price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.urImage,
    required this.price,
  });

  ProductModel toProductModel() {
    return ProductModel(id: id, name: name, urImage: urImage, price: price);
  }
}
