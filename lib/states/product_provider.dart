import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mini_ecommerce_app/models/product_model.dart';
import 'package:mini_ecommerce_app/services/product_service.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

final productListProvider = FutureProvider<List<ProductModel>>((ref) {
  return ref.read(productServiceProvider).fetchAllProducts();
});

final seacrhQueryProvider = StateProvider<String>((ref) {
  return '';
});

final filterProductListProvider = Provider<AsyncValue<List<ProductModel>>>((
  ref,
) {
  final productAsync = ref.watch(productListProvider);
  final searchQuery = ref.watch(seacrhQueryProvider).toLowerCase();
  return productAsync.whenData((value) {
    if (searchQuery.isEmpty) return value;
    return value.where((element) {
      return element.title.toLowerCase().contains(searchQuery);
    }).toList();
  });
});
