import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_bloc_example/cubit/product_cubit.dart';
import 'package:graphql_bloc_example/cubit/product_state.dart';

class ProductsPage extends StatefulWidget {
  final String title;
  const ProductsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<ProductCubit>();
      cubit.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is InitProductState || state is LoadingProductState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ResponseProductState) {
          final products = state.products;
          return Center(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                  );
                }),
          );
        } else if (state is ErrorProductState) {
          return Center(
            child: Text(state.message),
          );
        }

        return Center(
          child: Text(state.toString()),
        );
      }),
    );
  }
}
