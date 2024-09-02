import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentProfile extends StatefulWidget {
  const CurrentProfile({Key? key}) : super(key: key);

  @override
  State<CurrentProfile> createState() => _CurrentProfileState();
}

class _CurrentProfileState extends State<CurrentProfile> {
  // Controllers for customer info fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Controllers for shipping address fields
  final TextEditingController _unitNumberController = TextEditingController();
  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _specialInstructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCustomerData();
  }

  Future<void> fetchCustomerData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      final customerInfo = userDoc['customer_info'] as Map<String, dynamic>? ?? {};
      final shippingAddress = userDoc['shipping_address'] as Map<String, dynamic>? ?? {};

      setState(() {
        _nameController.text = customerInfo['name'] ?? '';
        _emailController.text = customerInfo['email'] ?? '';
        _phoneController.text = customerInfo['phone'] ?? '';

        _unitNumberController.text = shippingAddress['unit_number'] ?? '';
        _streetAddressController.text = shippingAddress['street_address'] ?? '';
        _cityController.text = shippingAddress['city'] ?? '';
        _provinceController.text = shippingAddress['province'] ?? '';
        _postalCodeController.text = shippingAddress['postal_code'] ?? '';
        _countryController.text = shippingAddress['country'] ?? '';
        _specialInstructionsController.text = shippingAddress['special_instructions'] ?? '';
      });
    }
  }

  Future<void> saveCustomerData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
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
      const SnackBar(content: Text('Profile information updated successfully!')),
    );
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
      //appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        "${FirebaseAuth.instance.currentUser!.photoURL}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                    const SizedBox(height: 8),
                    Text("${FirebaseAuth.instance.currentUser!.email}"),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const Text('Customer Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildTextField(_nameController, 'Name'),
              _buildTextField(_emailController, 'Email'),
              _buildTextField(_phoneController, 'Phone Number'),
              const SizedBox(height: 24),
              const Text('Shipping Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildTextField(_unitNumberController, 'Unit Number'),
              _buildTextField(_streetAddressController, 'Street Address'),
              _buildTextField(_cityController, 'City'),
              _buildTextField(_provinceController, 'Province'),
              _buildTextField(_postalCodeController, 'Postal Code'),
              _buildTextField(_countryController, 'Country'),
              _buildTextField(_specialInstructionsController, 'Special Instructions'),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: saveCustomerData,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _unitNumberController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }
}