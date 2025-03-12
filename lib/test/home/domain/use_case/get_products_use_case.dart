import 'package:final_project/test/home/domain/repository/home_repository.dart';
import 'package:final_project/test/home/presentation/model/product_model.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase({required this.homeRepository});

  List<ProductModel> invoke() {
    final List<ProductModel> products = [];
    final result = homeRepository.getProducts();
    for (var element in result) {
      products.add(element.toProductModel());
    }
    return products;
  }
}
