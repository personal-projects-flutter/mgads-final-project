import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/form_product/domain/repository/form_product_repository.dart';
import 'package:final_project/test/form_product/presentation/model/product_form_model.dart';

class AddProductUseCase {

  late final FormProductRepository formProductRepository;
  AddProductUseCase({required this.formProductRepository});

  Future<bool> invoke(ProductFormModel productFormModel) {
    try{
      final ProductEntity data = productFormModel.toEntity();
      return formProductRepository.addProduct(data);
    }catch(e){
      throw(Exception());
    }
  }
}
