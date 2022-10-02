const String getProducts = r'''
  query getProducts($nSize: Int!,$nChannel: String!){
    products(first: $nSize, channel: $nChannel) {
    edges {
      node {
        id
        name
        description
        thumbnail{
          url
        }
      }
    }
  }
  }
''';
