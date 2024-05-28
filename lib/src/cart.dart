import 'package:bkni/colors.dart';
import 'package:bkni/src/paymentoptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'cartcontroller.dart';
// imports
// import 'package:flutter_svg/flutter_svg.dart';
// import 'notifications.dart';

class CartPage extends StatefulWidget {
  const CartPage(
      {super.key,
      required this.name,
      required this.imgUrl,
      required this.price});
  final String name;
  final String imgUrl;
  final String price;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController =
      Get.put(CartController()); // Get.find<CartController>();
  final String imageVector = "assets/images/img_vector.svg";

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter += 1;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter -= 1;
    });
  }

  @override
  void initState() {
    super.initState();
    cartController.loadCartItems();
  }

  final isCheckedMap = <String, bool>{};
  // final isChecked = isCheckedMap[item['imgUrl']] ?? false;

  void updateCheckedState(String imgUrl, bool value) {
    isCheckedMap[imgUrl] = value;
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFFF6F6F6),
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Cart"),
        actions: [
          IconButton(
              onPressed: () => showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text(
                          "Are you sure you want to delete this item from your cart?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("No")),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            Navigator.pop(context, true);
                            final checkedItems = cartController.cartItems
                                .where((item) =>
                                    isCheckedMap[item['imgUrl']] == true)
                                .toList();
                            if (checkedItems.isNotEmpty) {
                              for (var item in checkedItems) {
                                cartController.removeFromCart(item['imgUrl']);
                                isCheckedMap.remove(item['imgUrl']);
                              }
                            }
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red[100]),
                          ),
                        ),
                      ],
                    ),
                  ),
              icon: const Icon(Icons.delete_outline_rounded)),
        ],
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
            // Products Cart List
            const SizedBox(
              height: 10,
            ),

            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    //final isChecked = false;
                    bool isChecked = isCheckedMap[item['imgUrl']] ??
                        false; // cartController.isChecked(item['imgUrl']) ?? false;

                    return ListTile(
                      leading: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            updateCheckedState(item['imgUrl'], value!);
                            setState(() {}); // Trigger rebuild
                          }),
                      title: Text(
                        item['name'],
                        style: const TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        "US 6\nRWF${item['price']}",
                        style: const TextStyle(fontSize: 8),
                      ),
                      trailing: SizedBox(
                        height: 200,
                        width: 111,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                      fixedSize: const Size(20, 20)),
                                  onPressed: _resetCounter,
                                  icon: const Text(
                                    "-",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  )),
                            ),
                            // ElevatedButton(style: ElevatedButton.styleFrom(fixedSize: const Size(2, 2)), onPressed: _incrementCounter, child: const Text("-")),
                            Text(
                              "$_counter",
                              style: const TextStyle(fontSize: 8),
                            ),
                            Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: mcgpalette0,
                                      fixedSize: const Size(5, 5)),
                                  onPressed: _incrementCounter,
                                  icon: const Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  )),
                            ),
                            // ElevatedButton(style: ElevatedButton.styleFrom(fixedSize: const Size(2, 2)), onPressed: _incrementCounter, child: const Text("+")),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: ElevatedButton(
            onPressed: () {
              final checkedItems = cartController.cartItems
                  .where((item) => isCheckedMap[item['imgUrl']] == true)
                  .toList();
              if (checkedItems.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PaymentOptions(
                              name: checkedItems.first['name'],
                              imgUrl: checkedItems.first['imgUrl'],
                              price: checkedItems.first['price'],
                            )));
              } else {
                //Navigator.pop(context);

                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    // Combine label and content into a single Row for top alignment
                    content: const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Align content horizontally
                      children: [
                        Text(
                            "Please, select an items\nTo proceed to payment\noptions."), // Short text at the end
                        Flexible(
                          // Makes label text wrap if needed
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14), // Adjust font size as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.redAccent,
                    action: SnackBarAction(
                      label: "View Cart",
                      onPressed: () {
                        // Navigator.pop(context);
                      }, // On-click action
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300, 50),
              backgroundColor: const Color(0xFF159954),
            ),
            child: const Text(
              "Checkout",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    );
  }
}


/*
                            //value = isCheckedMap[item['imgUrl']] ?? false;
                            //updateCheckedState(item['imgUrl'], value);
                            // Update isChecked based on current value
                            setState(() {
                              isChecked = !isChecked;
                              updateCheckedState(item['imgUrl'], isChecked);
                            }); */

                /*
                scaffoldMessenger.showSnackBar(
                  // SnackPosition: SnackPosition.TOP,
                  SnackBar(
                    //margin: margin,
                    content: const Text("No items Seletected"),
                    backgroundColor: Colors.redAccent,
                    action: SnackBarAction(
                        label:
                            "Please, select items from your cart to proceed to checkout.",
                        onPressed: () {}),
                    duration: const Duration(seconds: 4),
                  ),
                ); */