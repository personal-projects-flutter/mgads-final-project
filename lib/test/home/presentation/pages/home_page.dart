import 'package:final_project/test/di/dependency_injection.dart';
import 'package:final_project/test/home/presentation/bloc/home_bloc.dart';
import 'package:final_project/test/home/presentation/bloc/home_event.dart';
import 'package:final_project/test/home/presentation/bloc/home_state.dart';
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
                          Navigator.of(context).pop();
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
              itemCount: 2,
              itemBuilder: (context, index) => ProductItemWidget(),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image.asset('assets/box.png', width: 150.0),

          // Image.network(
          //   "https://cdn-icons-png.freepik.com/256/10266/10266140.png",
          //   width: 150.0,
          //   fit: BoxFit.contain,
          // ),
          SizedBox(
            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("Producto 1"), Text("Precio: \$100.00")],
            ),
          ),
        ],
      ),
    );
  }
}
