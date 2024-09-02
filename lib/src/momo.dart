import 'package:bkni/colors.dart';
import 'package:bkni/src/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';
import 'home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MomoPage extends StatefulWidget {
  final ProductData product;
  const MomoPage({super.key, required this.product});
  @override
  State<MomoPage> createState() => _MomoPageState();
}

class _MomoPageState extends State<MomoPage> {
  final logger = Logger();
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";

  bool isTestMode = true;

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;
    amountController.text = "${widget.product}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("MomoPay"),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  //initialValue: "${widget.product.price}" ?? "",
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: "Amount"),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Amount is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: currencyController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: _openBottomSheet,
                  decoration: const InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Currency is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  children: [
                    const Text("Use Debug"),
                    Switch(
                      onChanged: (value) => {
                        setState(() {
                          isTestMode = value;
                        })
                      },
                      value: isTestMode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mcgpalette0,
                  ),
                  onPressed: _onPressed,
                  child: const Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() async {
    final currentState = formKey.currentState;
    if (currentState != null && currentState.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final Customer customer = Customer(email: "customer@customer.com");

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-0ecb93e6c52b1c1c7625b9368f4992af-X",
        currency: selectedCurrency,
        redirectUrl: 'https://facebook.com',
        txRef: const Uuid().v1(),
        amount: amountController.text.toString().trim(),
        customer: customer,
        paymentOptions: "card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Test Payment"),
        isTestMode: isTestMode);
    final ChargeResponse response = await flutterwave.charge();
    if (response.status == "successful") {
      // Show payment confirmation dialog
      showLoading(response.toString());
      // Add order data to Firestore
      await FirebaseFirestore.instance.collection('orders').add({
        'client_uid':
            FirebaseAuth.instance.currentUser!.uid, // The current user's ID
        'order_id': 1, // This should be dynamically generated or managed
        'order_date': Timestamp.now(),
        'order_status': ['Processing'], // Initial status
        'payment_method': 'Card',
        'payment_status': 'Successful',
        'total_amount': widget.product.price *
            widget.product.quantity, // Assuming product has price and quantity
        'items': [
          {
            'name': widget.product.name,
            'price_per_unit': widget.product.price,
            'product_id': widget.product.product_id,
            'quantity': widget.product.quantity,
            'sku': widget.product.sku,
            'total_price': widget.product.price * widget.product.quantity,
            'notes': '', // Add any additional notes if required
          }
        ],
        'shipping_method': 'DHL', // Example
        'shipping_cost': 8000, // Example value
        'shipping_address':
            '22 KG 27 Ave', // Example address, replace with actual data
        'tracking_number': 509984, // Example tracking number
        'estimated_delivery_date': Timestamp.fromDate(
          DateTime.now().add(const Duration(days: 7)),
        ),
        'actual_delivery_date': null, // To be updated later
        'discount_applied': 5000, // Example, replace with actual discount
        'subtotal': widget.product.price *
            widget.product.quantity, // Calculate subtotal
        'tax_amount': 5000, // Example tax amount
        'customer_info': {
          'name': 'Phanny', // Example, replace with actual user info
          'email': FirebaseAuth.instance.currentUser!.email,
          'phone': '0798855432',
          'billing_address': '22 KG 24 Ave',
        },
        'gift_message': 'Enjoy these holidays', // Optional
        'coupon_code': 'M2SDFF', // Example coupon code
      });

      _navigateToConfirmPage();
    } else {
      showLoading(response.toString());
    }
    //showLoading(response.toString());
    //logger.d("${response.toJson()}");
  }

  void _navigateToConfirmPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ConfirmPage(
                  product: widget.product,
                )));
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["NGN", "RWF", "UGX", "KES", "ZAR", "USD", "GHS", "TZS"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {_handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
