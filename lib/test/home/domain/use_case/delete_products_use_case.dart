import 'package:final_project/test/home/domain/repository/home_repository.dart';

class DeleteProductUseCase {
  final HomeRepository homeRepository;

  DeleteProductUseCase({required this.homeRepository});

  Future<bool> invoke(String id) {
    try{
      return homeRepository.deleteProduct(id);
    }catch(e){
      throw(Exception(e));
    }
  }
}
