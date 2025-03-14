sealed class HomeEvent {}

final class GetProductEvent extends HomeEvent {
  GetProductEvent();
}

final class DeleteProductEvent extends HomeEvent {
  final String id;
  DeleteProductEvent({required this.id});
}

final class LogoutEvent extends HomeEvent {
  LogoutEvent();
}
