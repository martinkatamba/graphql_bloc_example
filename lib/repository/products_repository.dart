import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';

import 'package:graphql_bloc_example/queries/readProducts.dart' as queries;

class ProductsRepository {
  ProductsRepository();

  Future<QueryResult> getRepositories() async {
    final HttpLink httpLink = HttpLink(
      'https://demo.saleor.io/graphql/',
    );

    GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );

    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(queries.getProducts),
      variables: <String, dynamic>{'nSize': 10, 'nChannel': "default-channel"},
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
