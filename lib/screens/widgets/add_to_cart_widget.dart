// import 'package:flutter/material.dart';

// class AddToCartButtonWidget extends StatelessWidget {
//   AddToCartButtonWidget({super.key, required this.product});

//   final ProductEntity product;

//   final uid = FirebaseAuth.instance.currentUser?.uid;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartController>(
//       builder: (context, cartController, _) {
//         final qty = cartController.getQuantity(product.id);

//         // NOT IN CART → show Add button
//         if (qty == 0) {
// return ElevatedButton(
//   onPressed: () async {
//     await cartController.addToCart(product, uid ?? '');
//   },
//   child: Text("Add to cart"),
// );
//         }

//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: Icon(Icons.remove),
//               onPressed: () async {
//                 await cartController.updateQty(product.id, qty - 1, uid ?? '');
//               },
//             ),
//             Text(qty.toString()),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () async {
//                 await cartController.updateQty(product.id, qty + 1, uid ?? '');
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product_model.dart';
import '../../states/cart_provider.dart';

class AddToCartWidget extends ConsumerWidget {
  final ProductModel product;

  const AddToCartWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    final cartItem = cartItems
        .where((item) => item.product.id == product.id)
        .toList();

    if (cartItem.isEmpty) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        onPressed: () {
          ref.read(cartProvider.notifier).addToCart(product);
        },
        child: const Text("Add to Cart"),
      );
    }

    final qty = cartItem.first.quantity;

    return Row(
      children: [
        IconButton(
          onPressed: () {
            ref.read(cartProvider.notifier).decrement(product);
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          qty.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            ref.read(cartProvider.notifier).increment(product);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
