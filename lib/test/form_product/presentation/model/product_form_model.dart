import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/login/domain/entity/login_entity.dart';

final class ProductFormModel {
  final String id;
  final String name;
  final String price;
  final String urlImage;

  ProductFormModel({required this.id, required this.name, required this.price,
    required this.urlImage});

  ProductFormModel copyWith({String? id, String? name, String? price, String? urlImage}) {
    return ProductFormModel(

      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  ProductEntity toEntity() => ProductEntity(id: id, name: name, price: int.parse(price), urImage: urlImage);
}
