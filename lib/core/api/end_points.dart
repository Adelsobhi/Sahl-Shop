class EndPoints {
  static const String signUp='/api/v1/auth/signup';
  static const String login='/api/v1/auth/signin';
  static const String category='/api/v1/categories';
  static const String brand='/api/v1/brands';
  static const String product='/api/v1/products';
  static const String addToCart='/api/v1/cart';
  static const String getToCart='/api/v1/cart';
  static String subCategory(String categoryId) =>
      '/api/v1/categories/$categoryId/subcategories';
  static String order(String cartId) =>
      '/api/v2/orders/$cartId';

}
