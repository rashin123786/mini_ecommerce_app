import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mini_ecommerce_app/screens/screens/cart_screen.dart';
import 'package:mini_ecommerce_app/screens/screens/wishlist_screen.dart';
import 'package:mini_ecommerce_app/states/product_provider.dart';

import 'package:mini_ecommerce_app/screens/widgets/product_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAsync = ref.watch(filterProductListProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF232f3e),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistScreen()),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search products",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      ref.read(seacrhQueryProvider.notifier).state = value;
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredAsync.when(
              loading: () => Center(child: CircularProgressIndicator()),
              data: (data) {
                if (data.isEmpty) {
                  return Center(child: Text("No Products Found"));
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final product = data[index];
                      return ProductCard(productModel: product);
                    },
                  );
                }
              },
              error: (error, _) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
