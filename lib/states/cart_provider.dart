import 'package:flutter_riverpod/legacy.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(ProductModel product) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      state = [...state, CartItem(product: product, quantity: 1)];
    } else {
      state[index] = state[index].copyWith(quantity: state[index].quantity + 1);
      state = [...state];
    }
  }

  void increment(ProductModel product) {
    addToCart(product);
  }

  void decrement(ProductModel product) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      if (state[index].quantity > 1) {
        state[index] = state[index].copyWith(
          quantity: state[index].quantity - 1,
        );
        state = [...state];
      } else {
        removeFromCart(product);
      }
    }
  }

  void removeFromCart(ProductModel product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  double get totalPrice {
    return state.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}
