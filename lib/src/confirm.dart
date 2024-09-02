import 'package:bkni/colors.dart';
import 'package:bkni/src/branded.dart';
import 'package:bkni/src/paymentoptions.dart';
import 'package:bkni/src/trackorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
// imports
// import 'package:flutter_svg/flutter_svg.dart';
// import 'notifications.dart';
import 'home.dart';

class ConfirmPage extends StatefulWidget {
  final ProductData product;
  const ConfirmPage({super.key, required this.product});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final String imageVector = "assets/images/img_vector.svg";
  final String checkIcon = "assets/images/Check--Streamline-Core.svg";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFFF6F6F6),
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Payment Confirmation"),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Products Cart List

            // Success
            Column(
              children: [
                Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[50],
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 50.0,
                            left: 50.0,
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[100],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25.0,
                            left: 25.0,
                            child: Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[200],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50.0,
                            left: 50.0,
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[300],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  checkIcon,
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Center(
                      child: Text(
                    "Payment Successful",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                  )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 25.0, bottom: 20.0),
                  child: SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        "Total amount paid by VisaCard. Please, help us with our product reviews via Email.",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Total
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: mcgpalette0[50],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.product.name),
                          Text("${widget.product.price}"),
                        ],
                      ),
                    
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total"),
                          Text("${widget.product.price}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TrackOrderPage(product: widget.product,)));
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300, 50),
              backgroundColor: const Color(0xFF159954),
            ),
            child: const Text(
              "Proceed to Track Order",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    );
  }
}
