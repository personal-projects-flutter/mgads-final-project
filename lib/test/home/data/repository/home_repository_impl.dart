import 'package:final_project/test/core/data/remote/services/product_service.dart';
import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/home/domain/repository/home_repository.dart';
import 'package:final_project/test/home/presentation/model/product_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ProductService productService;

  HomeRepositoryImpl({required this.productService});

  @override
  Future<bool> deleteProduct(String id) {
    try{
      return productService.delete(id);
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    final List<ProductEntity> products = [];
    try {
      final response = await productService.getAll();
      for (var element in response) {
        products.add(element.toEntity());
      }
    } catch (e) {
      print("Error obteniendo datos del servidor: $e");
      throw Exception("Error: $e");
    }
    return products;
  }
}
