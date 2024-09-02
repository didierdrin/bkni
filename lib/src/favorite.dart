// favorite.dart
import 'package:bkni/src/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:bkni/src/favorite_controller.dart';
import 'package:bkni/src/home.dart'; // Import this to use ProductData

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (favoriteController.favoriteItems.isEmpty) {
          return const Center(
            child: Text("No favorite items yet."),
          );
        }
        return ListView.builder(
          itemCount: favoriteController.favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoriteController.favoriteItems[index];
            return Card(
              elevation: 1.0,
              child: ListTile(
                title: Text(item['name']),
                subtitle: Text("Price: ${item['price']}"),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    favoriteController.removeFromFavorites(item['name']);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductPage(
                        product: ProductData(
                          name: item['name'] ?? '',
                          price: (double.tryParse(item['price']) ?? 0).toDouble(),
                          description: item['description'] ?? '',
                          category: List<String>.from(item['category'] ?? []),
                          brand: item['brand'] ?? '',
                          quantity: item['quantity'] ?? 0,
                          color: item['color'] ?? '',
                          size: item['size'] ?? '',
                          sku: item['sku'] ?? '',
                          cost_price: (item['cost_price'] ?? 0).toDouble(),
                          discount_price:
                              (item['discount_price'] ?? 0).toDouble(),
                          material: item['material'] ?? '',
                          care_instructions: item['care_instructions'] ?? '',
                          shipping_weight:
                              (item['shipping_weight'] ?? 0).toDouble(),
                          available_colors:
                              List<String>.from(item['available_colors'] ?? []),
                          available_sizes:
                              List<String>.from(item['available_sizes'] ?? []),
                          tags: List<String>.from(item['tags'] ?? []),
                          img_url: item['img_url'] ?? '',
                          brand_uid: item['brand_uid'] ?? '',
                          date_added:
                              (item['date_added'] as Timestamp).toDate(),
                          last_updated:
                              (item['last_updated'] as Timestamp).toDate(),
                          is_active: item['is_active'] ?? false,
                          additional_images: List<String>.from(
                              item['additional_images'] ?? []),
                          bar_code: item['bar_code'] ?? '',
                          lead_time: item['lead_time'] ?? '',
                          product_id: item['product_id'] ?? 0,
                          reorder_point:
                              item['reorder_point'] ?? const GeoPoint(0, 0),
                          supplier_info: item['supplier_info'] ?? '',
                          tax_category: item['tax_category'] ?? '',
                          weight: (item['weight'] ?? 0).toDouble(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
