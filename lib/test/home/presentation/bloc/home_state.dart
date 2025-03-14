import 'package:final_project/test/home/presentation/model/home_model.dart';

sealed class HomeState {
  HomeState({required this.model});

  final HomeModel model;
}

final class EmptyState extends HomeState {
  EmptyState() : super(model: HomeModel(products: []));
}

final class LogoutState extends HomeState {
  LogoutState() : super(model: HomeModel(products: []));
}

final class LoadingState extends HomeState {
  final String message;
  LoadingState({this.message = "Cargando productos..."})
    : super(model: HomeModel(products: []));
}

final class LoadDataState extends HomeState {
  LoadDataState({required super.model});
}

final class HomeErrorState extends HomeState {
  HomeErrorState({required super.model, required this.message});
  final String message;
}
