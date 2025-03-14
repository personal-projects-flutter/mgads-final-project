import 'package:final_project/test/form_product/domain/use_case/add_product_use_case.dart';
import 'package:final_project/test/form_product/presentation/bloc/form_product_event.dart';
import 'package:final_project/test/form_product/presentation/bloc/form_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormProductBloc extends Bloc<FormProductEvent, FormProductState> {

  late final AddProductUseCase addProductUseCase;

  FormProductBloc({required this.addProductUseCase}) : super(InitialState()) {
    on<NameChangedEvent>(_nameChangedEvent);
    on<PriceChangedEvent>(_priceChangedEvent);
    on<UrlImageChangedEvent>(_urlImageChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  void _nameChangedEvent(NameChangedEvent event, Emitter<FormProductState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(name: event.name),
    );
    emit(newState);
  }

  void _priceChangedEvent(PriceChangedEvent event, Emitter<FormProductState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(price: event.price),
    );
    emit(newState);
  }

  void _urlImageChangedEvent(UrlImageChangedEvent event, Emitter<FormProductState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(urlImage: event.urlImage),
    );
    emit(newState);
  }



  void _submitEvent(SubmitEvent event, Emitter<FormProductState> emit) async {
    late final FormProductState newState;
    try{
      final bool result = await addProductUseCase.invoke(state.model);
      if (result){
        newState = SubmitSuccessState(model: state.model);
      }else{
        throw(Exception());
      }
    }catch(e){
      newState = SubmitErrorState(model: state.model, message: "Error al agregar un producto");
    }
    emit(newState);
  }
}
