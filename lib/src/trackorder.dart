import 'package:bkni/colors.dart';
import 'package:bkni/src/control.dart';
import 'package:bkni/src/home.dart';
import 'package:bkni/src/paymentoptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// imports
// import 'package:flutter_svg/flutter_svg.dart';
// import 'notifications.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage(
      {super.key,
      required this.product});
  final ProductData product; 
  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  final String nowDate =
      (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString();

  final String imageVector = "assets/images/img_vector.svg";
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFFF6F6F6),
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Track Order"),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ControlPage(customIndex: 0, product: widget.product)));
              },
              icon: const Icon(Icons.history_rounded))
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 600,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: mcgpalette0[50]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Order #215678",
                      style: TextStyle(color: mcgpalette0, fontSize: 17)),
                  const TextSpan(text: "\n"),
                  TextSpan(
                      text: "Purchase Date - $nowDate",
                      style: TextStyle(color: Colors.grey[500]))
                ])),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // height: 400,
                  decoration: BoxDecoration(
                      color: mcgpalette0[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                  value: false,
                                  groupValue: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  }),
                              VerticalDivider(
                                color: mcgpalette0[50],
                              ),
                            ],
                          ),
                          title: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                                text: "Confirm Order",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            const TextSpan(text: "\n"),
                            TextSpan(
                                text: nowDate,
                                style: TextStyle(color: Colors.grey[600]))
                          ])),
                        ),

                        ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                  value: false,
                                  groupValue: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  }),
                              VerticalDivider(
                                color: mcgpalette0[100],
                              ),
                            ],
                          ),
                          title: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                                text: "Product Prepared",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            const TextSpan(text: "\n"),
                            TextSpan(
                                text: nowDate,
                                style: TextStyle(color: Colors.grey[600]))
                          ])),
                        ),

                        ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                  value: false,
                                  groupValue: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  }),
                              VerticalDivider(
                                color: mcgpalette0[400],
                              ),
                            ],
                          ),
                          title: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                                text: "Shipped",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            const TextSpan(text: "\n"),
                            TextSpan(
                                text: "Processing",
                                style: TextStyle(color: Colors.grey[600]))
                          ])),
                        ),

                        ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                  value: false,
                                  groupValue: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  }),
                              VerticalDivider(
                                color: mcgpalette0[900],
                              ),
                            ],
                          ),
                          title: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                                text: "Out For Delivery",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            const TextSpan(text: "\n"),
                            TextSpan(
                                text: "Processing",
                                style: TextStyle(color: Colors.grey[600]))
                          ])),
                        ),

                        // Container(height: 10, decoration: BoxDecoration(border: Border.only()),),

                        ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                  value: false,
                                  groupValue: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  }),
                              const VerticalDivider(
                                color: Colors.black,
                              ),
                            ],
                          ),
                          title: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                                text: "Delivery",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            const TextSpan(text: "\n"),
                            TextSpan(
                                text: "Processing",
                                style: TextStyle(color: Colors.grey[600]))
                          ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
