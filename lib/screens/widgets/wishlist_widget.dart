import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product_model.dart';
import '../../states/wishlist_provider.dart';

class WishlistButton extends ConsumerWidget {
  final ProductModel product;
  const WishlistButton({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref
        .watch(wishlistProvider)
        .any((p) => p.id == product.id);

    return IconButton(
      icon: Icon(
        isWishlisted ? Icons.favorite : Icons.favorite_border,
        color: isWishlisted ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        ref.read(wishlistProvider.notifier).toggle(product);
      },
    );
  }
}
