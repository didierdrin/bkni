import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// imports
// import 'settings.dart';
// import 'package:bkni/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Bukon!"),
        
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
      ), */
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
                    suffixIcon: const Icon(Icons.search_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "What Are You Looking For?\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t|", // "What Are You Looking For?",
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Recent Search",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const Divider(),
              ListTile(
                title: const Text("Jordan 4"),
                subtitle: const Text("RWF120,000"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Nike Air OFF WHITE"),
                subtitle: const Text("RWF84,000"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
