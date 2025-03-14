import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/form_product/domain/repository/form_product_repository.dart';
import 'package:final_project/test/form_product/presentation/model/product_form_model.dart';

class UpdateProductUseCase {
  late final FormProductRepository formProductRepository;
  UpdateProductUseCase({required this.formProductRepository});

  Future<bool> invoke(ProductFormModel productFormModel) {
    try {
      final ProductEntity data = productFormModel.toEntity();
      return formProductRepository.updateProduct(data);
    } catch (e) {
      throw (Exception());
    }
  }
}
