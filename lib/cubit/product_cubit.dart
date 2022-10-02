import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_bloc_example/cubit/product_state.dart';
import 'package:graphql_bloc_example/models/product.dart';
import 'package:graphql_bloc_example/repository/products_repository.dart';
import 'dart:convert';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepository _productsRepository;
  ProductCubit(this._productsRepository) : super(InitProductState());

  Future<void> fetchProducts() async {
    emit(LoadingProductState());
    try {
      final result = await _productsRepository.getRepositories();

      if (result.hasException) {
        emit(ErrorProductState(result.exception.toString()));
      }

      if (result.isLoading) {
        emit(LoadingProductState());
      }

      List? products = result.data?['products']?['edges'];

      if (products == null) {
        emit(ErrorProductState("No Products Found"));
      } else {
        print(products);
        final output = products.map((row) {
          return Product(
              id: row['node']['id'],
              description: row['node']['description'],
              name: row['node']['name']);
        }).toList();

        emit(ResponseProductState(output));
      }
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }
}
