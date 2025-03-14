import 'package:dio/dio.dart';
import 'package:final_project/test/core/data/remote/dto/product_data_model.dart';
import 'package:final_project/test/home/presentation/model/product_model.dart';

final class ProductService {
  final Dio dio;
  final String _baseUrl =
      'https://storeappmgads2022-b465d-default-rtdb.firebaseio.com';
  // 'https://storeappmgads2022-b465d-default-rtdb.firebaseio.com';
  //'https://storeappmgads2022-b465d-default-rtdb.firebaseio.com';

  // 1:15:00

  ProductService({required this.dio});

  Future<List<ProductDataModel>> getAll() async {
    final List<ProductDataModel> products = [];
    try {
      // final Response<Map> response = await dio.get("$_baseUrl/products.json");
      final Response<Map> response = await dio.get("$_baseUrl/products.json");

      if (response.data != null) {
        response.data?.forEach((key, value) {
          products.add(ProductDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      throw Exception("Error!!!!: $e");
    }
    return products;
  }

  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_baseUrl/products/$id.json");
    } catch (e) {
      throw (Exception(e));
    }
    return true;
  }

  Future<bool> add(ProductDataModel product) async {
    try {
      await dio.post("$_baseUrl/products.json", data: product.toJson());
    } catch (e) {
      throw (Exception(e));
    }
    return true;
  }

  Future<ProductModel> get(String id) async {
    late final ProductDataModel product;
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/products/$id.json",
      );
      if (response.data != null) {
        product = ProductDataModel.fromJson(id, response.data!);
      }
    } catch (e) {
      throw (Exception(e));
    }
    return product.toModel();
  }

  Future<bool> update(ProductDataModel productDataModel) async {
    try {
      await dio.patch(
        "$_baseUrl/products/${productDataModel.id}.json",
        data: productDataModel.toJson(),
      );
    } catch (e) {
      throw (Exception(e));
    }
    return true;
  }
}
