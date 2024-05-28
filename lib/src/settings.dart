import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// imports
// import 'package:bkni/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Settings"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListTile(
              title: const Text("Feedback"),
              subtitle: const Text("Feel Free To Share Us Your Thoughts."),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Policy"),
              subtitle: const Text("Read Our Terms & Conditions."),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
