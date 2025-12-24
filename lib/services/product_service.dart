import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_ecommerce_app/models/product_model.dart';

class ProductService {
  static const _baseUrl = "https://fakestoreapi.com/";
  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await http.get(Uri.parse("${_baseUrl}products"));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
