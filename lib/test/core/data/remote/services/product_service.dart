import 'package:dio/dio.dart';
import 'package:final_project/test/core/data/remote/dto/product_data_model.dart';

final class ProductService {
  final Dio dio;
  final String _baseUrl =
      // 'https://storeappdamo2024-default-rtdb.firebaseio.com';
      'https://storeappmgads2022-b465d-default-rtdb.firebaseio.com/products';

  // 1:15:00

  ProductService({required this.dio});

  Future<List<ProductDataModel>> getAll() async {
    final List<ProductDataModel> products = [];
    try {
      // final Response<Map> response = await dio.get("$_baseUrl/products.json");
      final Response<Map> response = await dio.get(
        "https://storeappmgads2022-b465d-default-rtdb.firebaseio.com/products.json",
      );
      if (response.data != null) {
        response.data?.forEach((key, value) {
          products.add(ProductDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return products;
  }
}
