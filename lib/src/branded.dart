import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications.dart';
import 'product.dart';
import 'home.dart'; // Import this to use ProductData

class SortedPage extends StatefulWidget {
  const SortedPage({super.key});

  @override
  State<SortedPage> createState() => _SortedPageState();
}

class _SortedPageState extends State<SortedPage> {
  final _formKey = GlobalKey<FormState>();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Branded"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NotificationsPage()));
            },
            icon: const Icon(Icons.notifications_outlined),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                style: const TextStyle(fontSize: 14.0),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9),
                  prefixIcon: const Icon(Icons.search_outlined),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "What Are You Looking For?",
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("products")
                  .where('name', isGreaterThanOrEqualTo: _searchQuery)
                  .where('name', isLessThan: _searchQuery + 'z')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No products found"));
                }

                final docs = snapshot.data!.docs;
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = ProductData.fromMap(docs[index].data());
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductPage(
                              product: data,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.network(
                                  data.img_url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "RWF ${data.price.toStringAsFixed(2)}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.yellow, size: 16),
                                      Text("4.5",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
