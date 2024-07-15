import 'package:app/screens/cart_item.dart'; // Assuming CartItem class is defined in cart_item.dart

class CartManager {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
  }

  void removeCartItem(int index) {
    _cartItems.removeAt(index);
  }
}

final cartManager = CartManager();
