import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/wishlist_provider.dart';
import '../widgets/wishlist_widget.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: wishlist.isEmpty
          ? const Center(child: Text("No items in wishlist"))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (_, index) {
                final product = wishlist[index];
                return ListTile(
                  leading: Image.network(product.image, width: 50),
                  title: Text(product.title),
                  trailing: WishlistButton(product: product),
                );
              },
            ),
    );
  }
}
