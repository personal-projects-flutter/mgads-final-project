import 'dart:math';

import 'package:final_project/test/core/data/remote/services/product_service.dart';
import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/form_product/domain/repository/form_product_repository.dart';

class FormProductRepositoryImpl implements FormProductRepository {
  final ProductService productService;

  FormProductRepositoryImpl({required this.productService});

  @override
  Future<bool> addProduct(ProductEntity productEntity) {
    try{
      return productService.add(productEntity.toProductDataModel());
    }catch(e){
      throw(Exception());
    }

  }
}
