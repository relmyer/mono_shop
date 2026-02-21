import 'package:flutter/foundation.dart';
import '../../../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  String selectedSize;

  CartItem({
    required this.product,
    required this.quantity,
    required this.selectedSize,
  });
}

class CartState extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get total =>
      _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  void addItem(Product product, String size, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == size,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        selectedSize: size,
      ));
    }
    notifyListeners();
  }

  void removeItem(String productId, String size) {
    _items.removeWhere(
      (item) => item.product.id == productId && item.selectedSize == size,
    );
    notifyListeners();
  }

  void updateQuantity(String productId, String size, int quantity) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId && item.selectedSize == size,
    );
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
