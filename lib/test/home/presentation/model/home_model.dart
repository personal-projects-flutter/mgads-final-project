import 'package:final_project/test/home/presentation/model/product_model.dart';

class HomeModel {
  final List<ProductModel> products;

  HomeModel({required this.products});

  HomeModel copyWith({List<ProductModel>? products}) {
    return HomeModel(products: products ?? this.products);
  }
}
