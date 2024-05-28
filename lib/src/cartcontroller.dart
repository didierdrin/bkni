// Cart Controller
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxList<Map<String, dynamic>> _cartItems =
      RxList<Map<String, dynamic>>([]);
  @override
  void onInit() {
    super.onInit();
    _currentUser.value = _auth.currentUser;
    _currentUser.listen((user) {
      if (user != null) {
        // Load cart items from Fireabse(implementation in step 5)
        loadCartItems();
      }
    });
  }

  void addToCart(String imgUrl, String name, String price) {
    if (_currentUser.value != null) {
      _cartItems.add({
        'imgUrl': imgUrl,
        'name': name,
        'price': price,
      });
      // Add product to cart in Firebase (implementation in step ..)
      addItemToCartFirebase(imgUrl, name, price);
    }
  }

  void removeFromCart(int index) {
    if (_currentUser.value != null) {
      final item = _cartItems.removeAt(index);
      // Remove product from cart in Firebase(implementation in step ..)
      removeItemFromCartFirebase(item['imgUrl']);
    }
  }

  List<Map<String, dynamic>> get cartItems => _cartItems.toList();

  Future<void> loadCartItems() async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart');

      // Get cart items form Firebase Firestore
      final cartSnapshot = await cartRef.get();
      _cartItems.clear();
      for (var doc in cartSnapshot.docs) {
        final data = doc.data();
        _cartItems.add({
          'imgUrl': data['imgUrl'],
          'name': data['name'],
          'price': data['price'],
        });
      }
    }
  }

  Future<void> addItemToCartFirebase(
      String imgUrl, String name, String price) async {
    if (_currentUser.value != null) {
      // Implement Logic to add the product detail to the user's collection in Firebase
      final uid = _currentUser.value!.uid;
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart');
      // Add product details to the user's cart collection
      await cartRef.add({
        'imgUrl': imgUrl,
        'name': name,
        'price': price,
      });
    }
  }

  Future<void> removeItemFromCartFirebase(String imgUrl) async {
    if (_currentUser.value != null) {
      // Implement logic to remove the product from the user's collection based on the _currentUserID
      final uid = _currentUser.value!.uid;
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart');

      // Get a reference to the document containing the item
      final itemRef = await cartRef
          .where('imgUrl', isEqualTo: imgUrl)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.first.reference;
        } else {
          return null;
        }
      });

      // Check if the item reference is valid before deleting
      if (itemRef != null) {
        await itemRef.delete();
        print("Item with imgUrl: $imgUrl deleteed successfully from Firebase");
      } else {
        print("Item with imgUrl: $imgUrl not found in Firebase cart");
      }
    } else {
      print("No user logged in. Cannot delete item from Firebase storage");
    }
  }
}
