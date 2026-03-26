import 'package:bkni/src/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    const ussdCode = '*182*8*1*101010*tota# Bukoni';
    return Column(
      children: [
        // Braintree card payment is disabled (plugin is not compatible with current Flutter toolchain).
        InkWell(
          onTap: () {
            if (customerInfo != null && shippingAddress != null) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Pay via USSD'),
                  content: const Text(
                    'Dial this code to pay:\n\n*182*8*1*101010*tota# Bukoni',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: ussdCode));
                        Navigator.pop(context);
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('USSD code copied'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text('Copy Code'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ConfirmPage(product: widget.product),
                          ),
                        );
                      },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              );
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
              leading: Icon(Icons.dialpad),
              title: Text("Pay with USSD"),
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
