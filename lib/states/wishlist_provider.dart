import 'package:flutter_riverpod/legacy.dart';

import '../models/product_model.dart';

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<ProductModel>>(
      (ref) => WishlistNotifier(),
    );

class WishlistNotifier extends StateNotifier<List<ProductModel>> {
  WishlistNotifier() : super([]);

  void toggle(ProductModel product) {
    if (state.any((e) => e.id == product.id)) {
      state = state.where((e) => e.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isWishlisted(int productId) {
    return state.any((e) => e.id == productId);
  }
}
