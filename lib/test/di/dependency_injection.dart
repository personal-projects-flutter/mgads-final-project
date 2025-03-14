import 'package:dio/dio.dart';
import 'package:final_project/test/core/data/remote/services/product_service.dart';
import 'package:final_project/test/core/data/repository/session_repository_impl.dart';
import 'package:final_project/test/core/domain/repository/session_repository.dart';
import 'package:final_project/test/core/domain/use_case/logout_use_case.dart';
import 'package:final_project/test/form_product/data/repository/form_product_repository_impl.dart';
import 'package:final_project/test/form_product/domain/repository/form_product_repository.dart';
import 'package:final_project/test/form_product/domain/use_case/add_product_use_case.dart';
import 'package:final_project/test/form_product/domain/use_case/get_product_use_case.dart';
import 'package:final_project/test/form_product/domain/use_case/update_product_use_case.dart';
import 'package:final_project/test/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:final_project/test/home/data/repository/home_repository_impl.dart';
import 'package:final_project/test/home/domain/repository/home_repository.dart';
import 'package:final_project/test/home/domain/use_case/delete_products_use_case.dart';
import 'package:final_project/test/home/domain/use_case/get_products_use_case.dart';
import 'package:final_project/test/home/presentation/bloc/home_bloc.dart';
import 'package:final_project/test/login/data/repository/login_repository_impl.dart';
import 'package:final_project/test/login/domain/repository/login_repository.dart';
import 'package:final_project/test/login/domain/use_case/login_use_case.dart';
import 'package:final_project/test/login/presentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

final class DependencyInjection {
  DependencyInjection._();
  static final serviceLocator = GetIt.instance;

  static setup() {
    serviceLocator.registerSingleton<Dio>(Dio());
    serviceLocator.registerFactory<ProductService>(
      () => ProductService(dio: serviceLocator.get()),
    );

    serviceLocator.registerFactory<SessionRepository>(
      () => SessionRepositoryImpl(),
    );
    serviceLocator.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(sessionRepository: serviceLocator.get()),
    );

    serviceLocator.registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(),
    );
    serviceLocator.registerFactory<LoginUseCase>(
      () => LoginUseCase(loginRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: serviceLocator.get()),
    );

    // serviceLocator.registerFactory<HomeRepository>(
    //   () => HomeRepositoryImpl(productService: serviceLocator.get()),
    // );
    serviceLocator.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(productService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(homeRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<DeleteProductUseCase>(
      () => DeleteProductUseCase(homeRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<HomeBloc>(
      () => HomeBloc(
        getProductsUseCase: serviceLocator.get(),
        deleteProductsUseCase: serviceLocator.get(),
        logoutUseCase: serviceLocator.get(),
      ),
    );

    serviceLocator.registerFactory<FormProductRepository>(
      () => FormProductRepositoryImpl(productService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<AddProductUseCase>(
      () => AddProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetProductUseCase>(
      () => GetProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UpdateProductUseCase>(
      () => UpdateProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<FormProductBloc>(
      () => FormProductBloc(
        addProductUseCase: serviceLocator.get(),
        getProductUseCase: serviceLocator.get(),
        updateProductUseCase: serviceLocator.get(),
      ),
    );
  }
}
