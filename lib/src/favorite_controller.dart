// FavoriteController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteController extends StateNotifier<List<DocumentSnapshot>> {
  final String? userId;
  FavoriteController(this.userId) : super([]);

  Future<void> addToFav(DocumentSnapshot product) async {
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .doc(product.id)
          .set(product[0]!);
      state = [...state, product];
    }
  }

  Future<void> removeFromFav(DocumentSnapshot product) async {
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .doc(product.id)
          .delete();
    }
  }
}
