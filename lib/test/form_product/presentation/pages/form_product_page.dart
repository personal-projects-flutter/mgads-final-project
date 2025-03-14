import 'dart:async';

import 'package:final_project/test/di/dependency_injection.dart';
import 'package:final_project/test/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:final_project/test/form_product/presentation/bloc/form_product_event.dart';
import 'package:final_project/test/form_product/presentation/bloc/form_product_state.dart';
import 'package:final_project/test/login/presentation/pages/login_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FormProductPage extends StatelessWidget {
  final String? id;
  const FormProductPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<FormProductBloc>(),
      child: Scaffold(
        // Para que cuando aparezca el teclado, no desplace el contenido, sino
        // que el teclado quede arriba del contenido
        // Para que la vista no se ajuste al teclado cuando se muestre
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(id == null ? "Agregar producto" : "Editar producto"),
        ),
        body: Column(children: [BodyLoginWidget(id)]),
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  BodyLoginWidget(this.id, {super.key});
  final String? id;

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormProductBloc>();
    if (widget.id != null) {
      bloc.add(GetProductEvent(widget.id!));
    }

    TextEditingController nameField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    TextEditingController urlField = TextEditingController();

    return BlocListener<FormProductBloc, FormProductState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            break;
          case SubmitErrorState():
            showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('AlertDialog Title'),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Aceptar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
            );
            break;
          // default:
        }
      },
      child: BlocBuilder<FormProductBloc, FormProductState>(
        builder: (context, state) {
          nameField.text = state.model.name;
          priceField.text = state.model.price;
          urlField.text = state.model.urlImage;
          return Expanded(
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 32.0),
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    Text(state.model.name),
                    TextFormField(
                      controller: nameField,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged:
                          (value) => bloc.add(NameChangedEvent(name: value)),
                      // initialValue: "Usuario",
                      decoration: InputDecoration(
                        labelText: "Name:",
                        icon: Icon(Icons.card_giftcard),
                        hintText: "Nombre del producto",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: priceField,
                      onChanged:
                          (value) => setState(() {
                            bloc.add(PriceChangedEvent(price: value));
                          }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Precio",
                        icon: Icon(Icons.attach_money),
                        hintText: "Escribe el precio del producto",
                        // suffixIcon: GestureDetector(
                      ),
                    ),
                    TextFormField(
                      controller: urlField,
                      onChanged:
                          (value) => setState(() {
                            bloc.add(UrlImageChangedEvent(urlImage: value));
                          }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "URL",
                        icon: Icon(Icons.image),
                        hintText: "Escribe la URL del producto",
                        // suffixIcon: GestureDetector(
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FilledButton(
                      // onPressed: () => {keyForm.currentState?.validate()},
                      onPressed: () => {bloc.add(SubmitEvent())},
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.id == null ? "Crear" : "Actualizar",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
