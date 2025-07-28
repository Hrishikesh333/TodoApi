import 'dart:convert';

import 'package:api_using_flutter/products_api/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApiServices{

  final url = "https://dummyjson.com/products";

  Future<List<ProductModel>?> getdata(BuildContext context)async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);

        List<dynamic> products = data["products"];

        return products.map((key){
          return ProductModel.fromJson(key);
        }).toList();
      }
      // return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong $e")));

    }
  }



}
