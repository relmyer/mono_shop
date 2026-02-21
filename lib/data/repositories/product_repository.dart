import '../../models/product.dart';
import '../mock/products_mock.dart';

class ProductRepository {
  // Simulate a singleton repository
  static final ProductRepository _instance = ProductRepository._internal();
  factory ProductRepository() => _instance;
  ProductRepository._internal();

  final List<Product> _products = ProductsMock.products;

  List<Product> getAll() => List.unmodifiable(_products);

  List<Product> getByCategory(String category) {
    if (category == 'All') return getAll();
    return _products.where((p) => p.category == category).toList();
  }

  List<Product> getRecommended({int limit = 6}) {
    final sorted = List<Product>.from(_products)
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(limit).toList();
  }

  List<Product> getBestSellers({int limit = 6}) {
    final sorted = List<Product>.from(_products)
      ..sort((a, b) => b.soldCount.compareTo(a.soldCount));
    return sorted.take(limit).toList();
  }

  List<Product> getLatest({int limit = 6}) =>
      _products.reversed.take(limit).toList();

  List<Product> getByPriceAsc({int limit = 6}) {
    final sorted = List<Product>.from(_products)
      ..sort((a, b) => a.price.compareTo(b.price));
    return sorted.take(limit).toList();
  }

  Product? getById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void toggleFavorite(String id) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index].isFavorite = !_products[index].isFavorite;
    }
  }

  List<Product> getFavorites() =>
      _products.where((p) => p.isFavorite).toList();

  List<Product> search(String query) {
    final q = query.toLowerCase();
    return _products
        .where((p) =>
            p.title.toLowerCase().contains(q) ||
            p.brand.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q))
        .toList();
  }
}
