// import 'dart:math';

import 'package:bkni/src/cart.dart';
import 'package:bkni/src/cartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// imports
// import 'settings.dart';

// import 'package:bkni/colors.dart';

class ProductPage extends StatefulWidget {
  const ProductPage(
      {super.key,
      required this.name,
      required this.imgUrl,
      required this.price,
      required this.descriptionTxt});
  final String name;
  final String imgUrl;
  final String price;
  final String descriptionTxt;
  // product related variables to be passed into this class.

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final String imageVector = "assets/images/img_vector.svg";

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Product Details"),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Details
            Container(
              width: 400,
              height: 300,
              decoration: const BoxDecoration(
                  // color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )),
              child: Center(
                  child: Image.network(
                widget.imgUrl,
                fit: BoxFit.cover,
              )),
            ),

            ListTile(
                title: Text(widget.name),
                subtitle: Text("RWF ${widget.price}"),
                trailing: GestureDetector(
                  onTap: () => Get.find<CartController>()
                      .addToCart(widget.imgUrl, widget.name, widget.price),
                  child: const Icon(Icons.favorite_outline_rounded),
                )),

            const Divider(),

            ListTile(
              title: const Text("Select Size"),
              subtitle: Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF616161),
                      ),
                      onPressed: _incrementCounter,
                      child: const Text(
                        "XL",
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      )),
                ],
              ),
              trailing: const Text("Select Size"),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Descriptions",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 110.0),
              child: SizedBox(
                // decoration: const BoxDecoration(color: Color(0xFFF6F6F6)),
                // height: 300,
                child: Center(
                  child: Text(widget.descriptionTxt),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ), // Margin to the bottom nxt2 BUY NOW
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => Get.find<CartController>()
                  .addToCart(widget.imgUrl, widget.name, widget.price),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Colors.black,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "ADD TO CART",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CartPage(
                              name: widget.name,
                              price: widget.price,
                              imgUrl: widget.imgUrl,
                            )));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: const Color(0xFF159954),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.shopping_bag_outlined, color: Colors.black,),
                SizedBox(width: 10,),
                Text(
                "BUY NOW",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}







/*

// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final userChangesProvider = StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final favoriteControllerProvider = StateNotifierProvider<FavoriteController, List<DocumentSnapshot>>((ref) {
  final user = ref.watch(userChangesProvider);
  if (user.data?.value?.uid != null) {
    return FavoriteController(user.data!.value!.uid);
  } else {
    return FavoriteController(null);
  }
});

// favorite_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteController extends StateNotifier<List<DocumentSnapshot>> {
  final String? userId;
  FavoriteController(this.userId) : super([]);

  Future<void> addToFav(DocumentSnapshot product) async {
    if (userId != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).collection('favorites').doc(product.id).set(product.data()!);
      state = [...state, product];
    }
  }

  Future<void> removeFromFav(DocumentSnapshot product) async {
    if (userId != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).collection('favorites').doc(product.id).delete();
      state = state.where((item) => item.id != product.id).toList();
    }
  }
}


*/ 