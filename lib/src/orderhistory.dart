// orderhistory.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'orderhistorycontroller.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final OrderHistoryController orderHistoryController = Get.put(OrderHistoryController());

  @override
  void initState() {
    super.initState();
    orderHistoryController.loadOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Order History"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close_outlined),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Obx(
        () => orderHistoryController.orderHistory.isEmpty
            ? const Center(
                child: Text(
                  "No orders yet",
                  style: TextStyle(fontSize: 14),
                ),
              )
            : ListView.builder(
                itemCount: orderHistoryController.orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistoryController.orderHistory[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ExpansionTile(
                      title: Text('Order #${order['orderId'].substring(0, 8)}'),
                      subtitle: Text(
                        'Date: ${DateFormat('MMM dd, yyyy').format(order['orderDate'])}\nStatus: ${order['status']}',
                      ),
                      trailing: Text(
                        '\$${order['totalAmount'].toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: order['items']?.length ?? 0,
                          itemBuilder: (context, itemIndex) {
                            final item = order['items'][itemIndex];
                            return ListTile(
                              leading: Image.network(
                                item['imgUrl'] ?? '',  // Assuming you have an image URL
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(item['name']),
                              subtitle: Text('Quantity: ${item['quantity']}'),
                              trailing: Text('\$${item['price']}'),
                            );
                          },
                        ),
                        if (order['shippingAddress'] != null) ...[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Shipping Address:\n'
                              '${order['shippingAddress']['unit_number']}, '
                              '${order['shippingAddress']['street_address']}, '
                              '${order['shippingAddress']['city']}, '
                              '${order['shippingAddress']['province']}, '
                              '${order['shippingAddress']['postal_code']}, '
                              '${order['shippingAddress']['country']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          if (order['shippingAddress']['special_instructions'] != null)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Special Instructions: ${order['shippingAddress']['special_instructions']}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                        ],
                        if (order['actualDeliveryDate'] != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Delivered On: ${DateFormat('MMM dd, yyyy').format(order['actualDeliveryDate'])}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
