import 'package:bkni/src/trackorder.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:bkni/src/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bkni/src/momo.dart';
import 'package:bkni/src/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentOptions extends StatefulWidget {
  final ProductData product;
  const PaymentOptions({super.key, required this.product});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  Map<String, dynamic>? customerInfo;
  Map<String, dynamic>? shippingAddress;
  bool isLoading = true;

  // Controllers for customer info fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Controllers for shipping address fields
  final TextEditingController _unitNumberController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _specialInstructionsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCustomerData();
  }

  Future<void> fetchCustomerData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists && userDoc.data() != null) {
      setState(() {
        customerInfo =
            userDoc.data()?['customer_info'] as Map<String, dynamic>?;
        shippingAddress =
            userDoc.data()?['shipping_address'] as Map<String, dynamic>?;

        // Populate the controllers if data exists
        if (customerInfo != null) {
          _nameController.text = customerInfo!['name'] ?? '';
          _emailController.text = customerInfo!['email'] ?? '';
          _phoneController.text = customerInfo!['phone'] ?? '';
        }

        if (shippingAddress != null) {
          _unitNumberController.text = shippingAddress!['unit_number'] ?? '';
          _streetAddressController.text =
              shippingAddress!['street_address'] ?? '';
          _cityController.text = shippingAddress!['city'] ?? '';
          _provinceController.text = shippingAddress!['province'] ?? '';
          _postalCodeController.text = shippingAddress!['postal_code'] ?? '';
          _countryController.text = shippingAddress!['country'] ?? '';
          _specialInstructionsController.text =
              shippingAddress!['special_instructions'] ?? '';
        }

        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<int> generateOrderId() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .orderBy('order_id', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final lastOrder = snapshot.docs.first.data() as Map<String, dynamic>;
      return lastOrder['order_id'] + 1;
    } else {
      return 1; // Start from 1 if no orders exist
    }
  }

  Future<void> saveCustomerData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'customer_info': {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      },
      'shipping_address': {
        'unit_number': _unitNumberController.text,
        'street_address': _streetAddressController.text,
        'city': _cityController.text,
        'province': _provinceController.text,
        'postal_code': _postalCodeController.text,
        'country': _countryController.text,
        'special_instructions': _specialInstructionsController.text,
      },
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Information updated successfully!')),
    );

    fetchCustomerData(); // Refresh the data
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Choose Payment Method"),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Display or collect customer info and shipping address
                    customerInfo != null && shippingAddress != null
                        ? _buildInfoDisplayCard()
                        : _buildInfoCollectionCard(),
                    const SizedBox(height: 16),
                    _buildPaymentMethods(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoDisplayCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Customer Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Name: ${customerInfo!['name']}'),
            Text('Email: ${customerInfo!['email']}'),
            Text('Phone: ${customerInfo!['phone']}'),
            const SizedBox(height: 16),
            const Text('Shipping Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
                '${shippingAddress!['unit_number']}, ${shippingAddress!['street_address']}, ${shippingAddress!['city']}, ${shippingAddress!['province']}, ${shippingAddress!['postal_code']}, ${shippingAddress!['country']}'),
            Text(
                'Special Instructions: ${shippingAddress!['special_instructions']}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Switch to edit mode
                setState(() {
                  customerInfo = null;
                  shippingAddress = null;
                });
              },
              child: const Text('Edit Information'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCollectionCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Your Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField(_nameController, 'Name'),
            _buildTextField(_emailController, 'Email'),
            _buildTextField(_phoneController, 'Phone Number'),
            const SizedBox(height: 24),
            const Text('Shipping Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField(_unitNumberController, 'Unit Number'),
            _buildTextField(_streetAddressController, 'Street Address'),
            _buildTextField(_cityController, 'City'),
            _buildTextField(_provinceController, 'Province'),
            _buildTextField(_postalCodeController, 'Postal Code'),
            _buildTextField(_countryController, 'Country'),
            _buildTextField(
                _specialInstructionsController, 'Special Instructions'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: saveCustomerData,
              child: const Text('Save Information'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Column(
      children: [
        InkWell(
          onTap: () async {
            if (customerInfo != null && shippingAddress != null) {
              // Check if all the required fields in shipping_address are filled
              if (shippingAddress!.containsKey('unit_number') &&
                  shippingAddress!['unit_number'].isNotEmpty &&
                  shippingAddress!.containsKey('street_address') &&
                  shippingAddress!['street_address'].isNotEmpty &&
                  shippingAddress!.containsKey('city') &&
                  shippingAddress!['city'].isNotEmpty &&
                  shippingAddress!.containsKey('province') &&
                  shippingAddress!['province'].isNotEmpty &&
                  shippingAddress!.containsKey('postal_code') &&
                  shippingAddress!['postal_code'].isNotEmpty &&
                  shippingAddress!.containsKey('country') &&
                  shippingAddress!['country'].isNotEmpty) {
                final request = BraintreeDropInRequest(
                  tokenizationKey: "sandbox_fwc29vc6_nr2dhwmg7vgqfw94",
                  collectDeviceData: true,
                  cardEnabled: true,
                );
                BraintreeDropInResult? result =
                    await BraintreeDropIn.start(request);
                if (result != null) {
                  print('Card payment successful: $result');

                  // Generate a unique order_id
                  int orderId = await generateOrderId();

                  // Add order data to Firestore
                  await FirebaseFirestore.instance.collection('orders').add({
                    'client_uid': FirebaseAuth.instance.currentUser!.uid,
                    'order_id': orderId, // Dynamically generated order ID
                    'order_date': Timestamp.now(),
                    'order_status': ['Processing'],
                    'payment_method': 'Card',
                    'payment_status': 'Successful',
                    'total_amount': widget.product.price * widget.product.quantity,
                    'items': [
                      {
                        'name': widget.product.name,
                        'price_per_unit': widget.product.price,
                        'product_id': widget.product.product_id,
                        'quantity': widget.product.quantity,
                        'sku': widget.product.sku,
                        'total_price': widget.product.price * widget.product.quantity,
                        'notes': 'Best quality - Sellers note',
                      }
                    ],
                    'shipping_method': 'Local - Kigali',
                    'shipping_cost': 2500,
                    'shipping_address': {
                      'unit_number': shippingAddress!['unit_number'],
                      'street_address': shippingAddress!['street_address'],
                      'city': shippingAddress!['city'],
                      'province': shippingAddress!['province'],
                      'postal_code': shippingAddress!['postal_code'],
                      'country': shippingAddress!['country'],
                      'special_instructions': shippingAddress!['special_instructions'] ?? '',
                    },
                    'tracking_number': Timestamp.now(),
                    'estimated_delivery_date': Timestamp.fromDate(
                      DateTime.now().add(const Duration(days: 2)),
                    ),
                    'actual_delivery_date': Timestamp.fromDate(
                      DateTime.now().add(const Duration(days: 5)),),
                    'discount_applied': 5000,
                    'subtotal': widget.product.price * widget.product.quantity,
                    'tax_amount': (widget.product.price * widget.product.quantity) * 0.18,
                    'customer_info': {
                      'name': customerInfo!['name'],
                      'email': customerInfo!['email'],
                      'phone': customerInfo!['phone'],
                    },
                    'gift_message': 'Enjoy these holidays',
                    'coupon_code': 'M2SDFF',
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ConfirmPage(product: widget.product)));
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Payment executed\nsuccessfully!"),
                          Flexible(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.greenAccent,
                      action: SnackBarAction(
                        label: "Track your order",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TrackOrderPage(product: widget.product),
                              ));
                        },
                      ),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } else {
                  print('Card payment failed');
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Payment failed\nReason: Card declined"),
                          Flexible(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.redAccent,
                      action: SnackBarAction(
                        label: "Choose Payment Option",
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                      ),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Please ensure all shipping address fields are complete before proceeding.'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Please complete your profile information before proceeding.'),
                  backgroundColor: Colors.orangeAccent,
                ),
              );
            }
          },
          child: const Card(
            child: ListTile(
              leading: Icon(Icons.payment),
              title: Text("Pay with Card"),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (customerInfo != null && shippingAddress != null) {
              // Handle mobile payment
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MomoPage(product: widget.product)));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Please complete your profile information before proceeding.'),
                  backgroundColor: Colors.orangeAccent,
                ),
              );
            }
          },
          child: const Card(
            child: ListTile(
              leading: Icon(Icons.phone_android),
              title: Text("Mobile Payment"),
            ),
          ),
        ),
      ],
    );
  }
}
