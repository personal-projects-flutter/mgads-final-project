import 'package:final_project/test/core/domain/use_case/logout_use_case.dart';
import 'package:final_project/test/home/domain/use_case/delete_products_use_case.dart';
import 'package:final_project/test/home/domain/use_case/get_products_use_case.dart';
import 'package:final_project/test/home/presentation/bloc/home_event.dart';
import 'package:final_project/test/home/presentation/bloc/home_state.dart';
import 'package:final_project/test/home/presentation/model/product_model.dart';
import 'package:final_project/test/login/domain/use_case/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductUseCase deleteProductsUseCase;
  final LogoutUseCase logoutUseCase;

  HomeBloc({
    required this.getProductsUseCase,
    required this.deleteProductsUseCase,
    required this.logoutUseCase,
  }) : super(LoadingState()) {
    on<GetProductEvent>(_getProductEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  void _getProductEvent(GetProductEvent event, Emitter<HomeState> emit) async {
    late HomeState newState;
    try {
      newState = LoadingState();
      emit(newState);

      final List<ProductModel> results = await getProductsUseCase.invoke();

      if (results.isEmpty) {
        newState = EmptyState();
      } else {
        newState = LoadDataState(
          model: state.model.copyWith(products: results),
        );
      }
    } catch (e) {
      newState = HomeErrorState(
        model: state.model,
        message: "Error al obtener los productos",
      );
    }
    emit(newState);
  }

  void _deleteProductEvent(
    DeleteProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    late HomeState newState;
    try {
      final bool result = await deleteProductsUseCase.invoke(event.id);
      if (result) {
        newState = LoadingState();
        emit(newState);
        final List<ProductModel> results = await getProductsUseCase.invoke();
        if (results.isEmpty) {
          newState = EmptyState();
        } else {
          newState = LoadDataState(
            model: state.model.copyWith(products: results),
          );
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      newState = HomeErrorState(
        model: state.model,
        message: "Error al eliminar el producto",
      );
    }
    emit(newState);
  }

  void _logoutEvent(LogoutEvent event, Emitter<HomeState> emit) async {
    logoutUseCase.invoke();
    emit(LogoutState());
  }
}
