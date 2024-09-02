// cartcontroller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxList<Map<String, dynamic>> _cartItems = RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    _currentUser.value = _auth.currentUser;
    _currentUser.listen((user) {
      if (user != null) {
        loadCartItems();
      }
    });
  }



  void addToCart(String imgUrl, String name, String price, int quantity, String selectedSize, String selectedColor) {
    if (_currentUser.value != null) {
      _cartItems.add({
        'imgUrl': imgUrl,
        'name': name,
        'price': price,
        'quantity': quantity,
        'size': selectedSize,
        'color': selectedColor,
      });
      addItemToCartFirebase(imgUrl, name, price, quantity, selectedSize, selectedColor);
    }
  }

  Future<void> addItemToCartFirebase(String imgUrl, String name, String price, int quantity, String selectedSize, String selectedColor) async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart');
      await cartRef.add({
        'imgUrl': imgUrl,
        'name': name,
        'price': price,
        'quantity': quantity,
        'size': selectedSize,
        'color': selectedColor,
      });
    }
  }

  void removeFromCart(String imgUrl) {
    if (_currentUser.value != null) {
      _cartItems.removeWhere((item) => item['imgUrl'] == imgUrl);
      removeItemFromCartFirebase(imgUrl);
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

      final cartSnapshot = await cartRef.get();
      _cartItems.clear();
      for (var doc in cartSnapshot.docs) {
        final data = doc.data();
        _cartItems.add({
          'imgUrl': data['imgUrl'],
          'name': data['name'],
          'price': data['price'],
          'quantity': data['quantity'] ?? 1,
        });
      }
    }
  }


  Future<void> removeItemFromCartFirebase(String imgUrl) async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart');

      final querySnapshot = await cartRef.where('imgUrl', isEqualTo: imgUrl).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      print("Item with imgUrl: $imgUrl deleted successfully from Firebase");
    } else {
      print("No user logged in. Cannot delete item from Firebase storage");
    }
  }

  void incrementQuantity(String imgUrl) {
    final index = _cartItems.indexWhere((item) => item['imgUrl'] == imgUrl);
    if (index != -1) {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 1) + 1;
      updateQuantityInFirebase(imgUrl, _cartItems[index]['quantity']);
    }
  }

  void decrementQuantity(String imgUrl) {
    final index = _cartItems.indexWhere((item) => item['imgUrl'] == imgUrl);
    if (index != -1) {
      final currentQuantity = _cartItems[index]['quantity'] ?? 1;
      if (currentQuantity > 1) {
        _cartItems[index]['quantity'] = currentQuantity - 1;
        updateQuantityInFirebase(imgUrl, _cartItems[index]['quantity']);
      }
    }
  }


  Future<void> updateQuantityInFirebase(String imgUrl, int quantity) async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart');

      final querySnapshot = await cartRef.where('imgUrl', isEqualTo: imgUrl).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.update({'quantity': quantity});
      }
    }
  }
}