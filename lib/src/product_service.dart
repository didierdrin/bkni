import 'package:bkni/src/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class ProductService {
  // Fetch product list from Firebase Firestore
  static Future<List<ProductData>> getProductList() async {
    try {
      // Get the products collection from Firestore
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();
      
      // Map the documents to ProductData instances
      List<ProductData> productList = snapshot.docs.map((doc) {
        return ProductData.fromMap(doc.data());
      }).toList();

      return productList;
    } catch (e) {
      // Handle any errors that might occur
      print("Error getting products: $e");
      return [];
    }
  }
}
