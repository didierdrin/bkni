import 'dart:convert';

import 'package:bkni/colors.dart';
import 'package:bkni/src/paymentoptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import 'package:http/http.dart' as http;
import '_helpbotcontroller.dart';
// import 'package:get/get.dart';
// imports
// import 'package:flutter_svg/flutter_svg.dart';
// import 'notifications.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final HelpbotController controller = Get.put(HelpbotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFFF6F6F6),
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Help"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_outlined)),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(() => Text(controller.chatHistory.value)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textController,
                          decoration: const InputDecoration(
                              hintText: "Ask anything..."),
                        ),
                      ),
                      IconButton(
                          onPressed: controller.sendMessage,
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black87,
                          )),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
