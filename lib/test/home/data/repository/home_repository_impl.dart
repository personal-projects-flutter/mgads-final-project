import 'package:final_project/test/core/domain/entity/product_entity.dart';
import 'package:final_project/test/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  bool deleteProduct(String id) {
    return false;
  }

  @override
  List<ProductEntity> getProducts() {
    return [
      ProductEntity(
        id: "343",
        name: "Teclado Mecanico",
        urImage:
            "https://www.kalley.com.co/medias/7705946478533-001-750Wx750H?context=bWFzdGVyfGltYWdlc3wyMjcwOHxpbWFnZS93ZWJwfGFEQmlMMmd4TVM4eE5ETTJOakV5T1RZeE9EazNOQzgzTnpBMU9UUTJORGM0TlRNelh6QXdNVjgzTlRCWGVEYzFNRWd8ZjkwOWI3NTkwZjYwMTdhMjFjMjA3ZWQ4MjY4MzdhNzM3MGI2ZGVhYjRmNjcwYWRmNWM4MGMxZmRkMWNkZmI4MA",
        price: 30000,
      ),
      ProductEntity(
        id: "343",
        name: "Teclado Mecanico",
        urImage:
            "https://www.kalley.com.co/medias/7705946478533-001-750Wx750H?context=bWFzdGVyfGltYWdlc3wyMjcwOHxpbWFnZS93ZWJwfGFEQmlMMmd4TVM4eE5ETTJOakV5T1RZeE9EazNOQzgzTnpBMU9UUTJORGM0TlRNelh6QXdNVjgzTlRCWGVEYzFNRWd8ZjkwOWI3NTkwZjYwMTdhMjFjMjA3ZWQ4MjY4MzdhNzM3MGI2ZGVhYjRmNjcwYWRmNWM4MGMxZmRkMWNkZmI4MA",
        price: 30000,
      ),
    ];
  }
}
