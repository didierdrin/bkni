// orderhistorycontroller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxList<Map<String, dynamic>> _orderHistory =
      RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    _currentUser.value = _auth.currentUser;
    _currentUser.listen((user) {
      if (user != null) {
        loadOrderHistory();
      }
    });
  }

  List<Map<String, dynamic>> get orderHistory => _orderHistory.toList();

  Future<void> loadOrderHistory() async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final orderRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('recent_orders');

      final orderSnapshot = await orderRef.get();
      _orderHistory.clear();
      for (var doc in orderSnapshot.docs) {
        final data = doc.data();
        _orderHistory.add({
          'orderId': doc.id,
          'items': data['items'] ?? [],
          'totalAmount': data['totalAmount'] ?? 0.0,
          'orderDate':
              (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
          'status': data['status'] ?? 'Unknown',
          'shippingAddress': data['shippingAddress'] ?? {},
          'actualDeliveryDate':
              (data['actualDeliveryDate'] as Timestamp?)?.toDate(),
        });
      }
    }
  }

  Future<void> addOrder(
      List<Map<String, dynamic>> items, double totalAmount) async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final orderRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('recent_orders');

      final newOrder = await orderRef.add({
        'items': items,
        'totalAmount': totalAmount,
        'orderDate': Timestamp.now(),
        'status': 'Pending',
      });

      _orderHistory.insert(0, {
        'orderId': newOrder.id,
        'items': items,
        'totalAmount': totalAmount,
        'orderDate': DateTime.now(),
        'status': 'Pending',
      });
    }
  }
}
