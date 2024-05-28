import 'dart:ffi';

import 'package:flutter/material.dart';

@immutable
class Stock {
  final Int productId;
  final String name;
  final String description;
  final Float price;
  final String color;
  final String size;
  final Float stockQuantity;
  // final String imgUrl;

  const Stock({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    required this.size,
    required this.stockQuantity,
    // required this.imgUrl,
  });

  Stock.fromJson(Map<String, Object?> json)
      : this(
          productId: json["product_id"]! as Int,
          name: json["name"]! as String,
          description: json["description"]! as String,
          price: json["price"]! as Float,
          color: json["color"]! as String,
          size: json["size"]! as String,
          stockQuantity: json["stock_quantity"]! as Float,
          // imgUrl: json["img_url"]! as String,
        );

  Map<String, Object?> toJson() {
    return {
      "productId": productId,
      "name": name,
      "description": description,
      "price": price,
      "color": color,
      "size": size,
      "stockQuantity": stockQuantity,
      // "imgUrl": imgUrl,
    };
  }
}
