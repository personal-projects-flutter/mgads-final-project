import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/form_product/domain/repository/form_product_repository.dart';
import 'package:final_project/test/form_product/presentation/model/product_form_model.dart';

class GetProductUseCase {
  late final FormProductRepository formProductRepository;
  GetProductUseCase({required this.formProductRepository});

  Future<ProductFormModel> invoke(String id) async {
    try {
      final data = await formProductRepository.getProduct(id);
      return ProductFormModel(
        id: data.id,
        name: data.name,
        price: data.price.toString(),
        urlImage: data.urImage,
      );
    } catch (e) {
      throw (Exception());
    }
  }
}
