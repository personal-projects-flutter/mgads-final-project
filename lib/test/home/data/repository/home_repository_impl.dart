import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  bool deleteProduct(String id) {
    return false;
  }

  @override
  List<ProductEntity> getProducts() {
    return [];
  }
}
