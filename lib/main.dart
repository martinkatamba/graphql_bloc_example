import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_bloc_example/cubit/product_cubit.dart';
import 'package:graphql_bloc_example/products_page.dart';
import 'package:graphql_bloc_example/repository/products_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(ProductsRepository()),
      child: MaterialApp(
        title: 'Graphql Bloc Cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductsPage(title: 'Graphql Bloc Cubit'),
      ),
    );
  }
}
