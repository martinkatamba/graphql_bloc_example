import 'package:graphql_bloc_example/models/product.dart';

abstract class ProductState {}

class InitProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class ErrorProductState extends ProductState {
  final String message;
  ErrorProductState(this.message);
}

class ResponseProductState extends ProductState {
  final List<Product> products;
  ResponseProductState(this.products);
}
