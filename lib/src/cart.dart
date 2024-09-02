import 'package:bkni/colors.dart';
import 'package:bkni/src/paymentoptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'cartcontroller.dart';
import 'home.dart';

class CartPage extends StatefulWidget {
  final ProductData product;
  const CartPage({super.key, required this.product});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.put(CartController());
  final isCheckedMap = <String, bool>{};

  @override
  void initState() {
    super.initState();
    cartController.loadCartItems();
  }

  void updateCheckedState(String imgUrl, bool value) {
    setState(() {
      isCheckedMap[imgUrl] = value;
    });
  }

  void reloadPage() {
    setState(() {
      // This empty setState will trigger a rebuild of the widget
    });
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var item in cartController.cartItems) {
      if (isCheckedMap[item['imgUrl']] == true) {
        total += (double.parse(item['price'].replaceAll('RWF', '')) *
            (item['quantity'] ?? 1));
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
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
                    "Are you sure you want to delete the selected items from your cart?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("No"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      final checkedItems = cartController.cartItems
                          .where((item) => isCheckedMap[item['imgUrl']] == true)
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
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Obx(() => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartController.cartItems[index];
                          bool isChecked =
                              isCheckedMap[item['imgUrl']] ?? false;

                          return ListTile(
                            leading: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                updateCheckedState(item['imgUrl'], value!);
                                reloadPage(); // Trigger rebuild to update total price
                              },
                            ),
                            title: Text(
                              item['name'],
                              style: const TextStyle(fontSize: 12),
                            ),
                            subtitle: Text(
                              "US 6\nRWF${item['price']}",
                              style: const TextStyle(fontSize: 8),
                            ),
                            trailing: SizedBox(
                              width: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  QuantityButton(
                                    icon: Icons.remove,
                                    onPressed: () {
                                      cartController
                                          .decrementQuantity(item['imgUrl']);
                                    },
                                    onQuantityChanged: reloadPage,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${item['quantity'] ?? 1}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  QuantityButton(
                                    icon: Icons.add,
                                    onPressed: () {
                                      cartController
                                          .incrementQuantity(item['imgUrl']);
                                    },
                                    onQuantityChanged: reloadPage,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  final checkedItems = cartController.cartItems
                      .where((item) => isCheckedMap[item['imgUrl']] == true)
                      .toList();
                  if (checkedItems.isNotEmpty) {
                    double totalPrice = calculateTotalPrice();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentOptions(
                          product: widget.product,
                        ), // checkedItems[0]
                      ),
                    );
                  } else {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Please select an item to proceed to payment options.",
                        ),
                        backgroundColor: Colors.redAccent,
                        action: SnackBarAction(
                          label: "View Cart",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CartPage(
                                        product: widget.product,)));
                          },
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF159954),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Checkout (RWF ${calculateTotalPrice().toStringAsFixed(2)})",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback onQuantityChanged;

  const QuantityButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: mcgpalette0,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 18),
        onPressed: () {
          onPressed();
          onQuantityChanged();
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
}
