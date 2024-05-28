

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// imports
import 'notifications.dart';
// import 'package:bkni/colors.dart';
import 'product.dart';

class SortedPage extends StatefulWidget {
  const SortedPage({super.key});

  @override
  State<SortedPage> createState() => _SortedPageState();
}

class _SortedPageState extends State<SortedPage> {
  final _formKey = GlobalKey<FormState>();

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
            statusBarIconBrightness: Brightness.dark),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  style: const TextStyle(fontSize: 14.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Search Something';
                    }
                    return null;
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
              const SizedBox(
                height: 5,
              ),
              // Divider
              const Divider(),
        
              Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Hard Coded Containers. ListBuilder
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ProductPage(name: "Some Name", price: "Some Price", imgUrl: "Some URL", descriptionTxt: "Some Description",)));
                        },
                        child: Ink(
                          width: 144.0,
                          height: 198.0,
                          color: const Color(0xFFD9D9D9),
                          child: Column(
                            children: [
                              Container(),
                              const Spacer(),
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: const Row(
                                  children: [
                                    Text("Nike SB 42 \nRWF83,990"),
                                    Spacer(),
                                    Icon(Icons.star_outline),
                                    Text("4.6")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
        
                      const SizedBox(
                        width: 10.0,
                      ),
        
                      Container(
                        width: 144.0,
                        height: 198.0,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(0.0)),
                      ),
                    ],
                  ),
                ),
        
            ],
          ),
        ),
      ),
    );
  }
}
