import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/models/product_model.dart';
import 'package:mini_ecommerce_app/screens/widgets/add_to_cart_widget.dart';
import 'package:mini_ecommerce_app/screens/widgets/wishlist_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      errorWidget: (context, url, error) => Icon(Icons.info),
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.topRight,
                    child: WishlistButton(product: product),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ListTile(
                title: Text(
                  product.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(product.description),
                trailing: Text(
                  "₹${product.price}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: AddToCartWidget(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
