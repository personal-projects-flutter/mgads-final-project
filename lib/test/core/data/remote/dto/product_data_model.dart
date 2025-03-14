import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/home/presentation/model/product_model.dart';

class ProductDataModel {
  final String id;
  late final String name;
  late final int price;
  late final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  ProductDataModel.fromJson(String this.id, Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    imageUrl = json['image'];
  }

  ProductEntity toEntity() {
    return ProductEntity(id: id, name: name, price: price, urImage: imageUrl);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name, "price": price, "image": imageUrl};
  }

  ProductModel toModel() {
    return ProductModel(id: id, name: name, price: price, urImage: imageUrl);
  }
}
