// favoritecontroller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxList<Map<String, dynamic>> _favoriteItems = RxList<Map<String, dynamic>>([]);

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems.toList();

  @override
  void onInit() {
    super.onInit();
    loadFavoriteItems();
  }

  Future<void> loadFavoriteItems() async {
    final user = _auth.currentUser;
    if (user != null) {
      final favoritesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');

      final favoritesSnapshot = await favoritesRef.get();
      _favoriteItems.clear();
      for (var doc in favoritesSnapshot.docs) {
        final data = doc.data();
        _favoriteItems.add({
          'name': data['name'] ?? '',
          'price': data['price'] ?? 0,
          'description': data['description'] ?? '',
          'category': data['category'] ?? [],
          'brand': data['brand'] ?? '',
          'quantity': data['quantity'] ?? 0,
          'color': data['color'] ?? '',
          'size': data['size'] ?? '',
          'sku': data['sku'] ?? '',
          'cost_price': data['cost_price'] ?? 0,
          'discount_price': data['discount_price'] ?? 0,
          'material': data['material'] ?? '',
          'care_instructions': data['care_instructions'] ?? '',
          'shipping_weight': data['shipping_weight'] ?? 0,
          'available_colors': List<String>.from(data['available_colors'] ?? []),
          'available_sizes': List<String>.from(data['available_sizes'] ?? []),
          'tags': List<String>.from(data['tags'] ?? []),
          'img_url': data['img_url'] ?? '',
          'brand_uid': data['brand_uid'] ?? '',
          'date_added': data['date_added'],
          'last_updated': data['last_updated'],
          'is_active': data['is_active'] ?? false,
          'additional_images': List<String>.from(data['additional_images'] ?? []),
          'bar_code': data['bar_code'] ?? '',
          'lead_time': data['lead_time'] ?? '',
          'product_id': data['product_id'] ?? 0,
          'reorder_point': data['reorder_point'],
          'supplier_info': data['supplier_info'] ?? '',
          'tax_category': data['tax_category'] ?? '',
          'weight': data['weight'] ?? 0,
        });
      }
    }
  }

  Future<void> addToFavorites(Map<String, dynamic> productData) async {
    final user = _auth.currentUser;
    if (user != null) {
      final favoritesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');

      // Ensure all necessary fields are present in productData
      final completeProductData = {
        'name': productData['name'] ?? '',
        'price': productData['price'] ?? 0,
        'description': productData['description'] ?? '',
        'category': productData['category'] ?? [],
        'brand': productData['brand'] ?? '',
        'quantity': productData['quantity'] ?? 0,
        'color': productData['color'] ?? '',
        'size': productData['size'] ?? '',
        'sku': productData['sku'] ?? '',
        'cost_price': productData['cost_price'] ?? 0,
        'discount_price': productData['discount_price'] ?? 0,
        'material': productData['material'] ?? '',
        'care_instructions': productData['care_instructions'] ?? '',
        'shipping_weight': productData['shipping_weight'] ?? 0,
        'available_colors': productData['available_colors'] ?? [],
        'available_sizes': productData['available_sizes'] ?? [],
        'tags': productData['tags'] ?? [],
        'img_url': productData['img_url'] ?? '',
        'brand_uid': productData['brand_uid'] ?? '',
        'date_added': productData['date_added'] ?? Timestamp.now(),
        'last_updated': productData['last_updated'] ?? Timestamp.now(),
        'is_active': productData['is_active'] ?? false,
        'additional_images': productData['additional_images'] ?? [],
        'bar_code': productData['bar_code'] ?? '',
        'lead_time': productData['lead_time'] ?? '',
        'product_id': productData['product_id'] ?? 0,
        'reorder_point': productData['reorder_point'],
        'supplier_info': productData['supplier_info'] ?? '',
        'tax_category': productData['tax_category'] ?? '',
        'weight': productData['weight'] ?? 0,
      };

      await favoritesRef.add(completeProductData);
      await loadFavoriteItems();
    }
  }

  Future<void> removeFromFavorites(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      final favoritesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');

      final querySnapshot = await favoritesRef.where('name', isEqualTo: name).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      await loadFavoriteItems();
    }
  }

  bool isFavorite(String name) {
    return _favoriteItems.any((item) => item['name'] == name);
  }
}