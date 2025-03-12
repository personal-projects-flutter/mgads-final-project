import 'package:final_project/test/di/dependency_injection.dart';
import 'package:final_project/test/home/presentation/bloc/home_bloc.dart';
import 'package:final_project/test/home/presentation/bloc/home_event.dart';
import 'package:final_project/test/home/presentation/bloc/home_state.dart';
import 'package:final_project/test/home/presentation/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependencyInjection.serviceLocator.get<HomeBloc>(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "Listado de Productos",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              SizedBox(width: 15.0),
              Icon(Icons.logout, color: Colors.white),
            ],
          ),
          body: ProductListWidget(),
        ),
      ),
    );
  }
}

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<HomeBloc>();
    bloc.add(GetProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case LoadingState() || EmptyState() || LoadDataState():
            break;
          case HomeErrorState():
            showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Aceptar'),
                        onPressed: () {
                          Navigator.pop(context, "Ok");
                          bloc.add(GetProductEvent());
                        },
                      ),
                    ],
                  ),
            );
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text(state.message),
                ],
              ),
            );
          case EmptyState():
            return Center(child: Text("No hay productos"));
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.products.length,
              itemBuilder:
                  (context, index) =>
                      ProductItemWidget(state.model.products[index]),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductItemWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
                title: const Text('Eliminación de Producto'),
                content: Text(
                  "Esta seguro de eliminar el prodcto?: ${product.name}",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context, 'Ok');
                      bloc.add(DeleteProductEvent(id: product.id));
                    },
                  ),
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context, 'Cancelar');
                    },
                  ),
                ],
              ),
        );
      },
      child: Card(
        child: Row(
          children: [
            Image.network(product.urImage, width: 150.0, fit: BoxFit.contain),
            SizedBox(
              height: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text(product.name), Text("\$${product.price}")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
