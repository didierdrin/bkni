// Payment Options - "Checkout button from CartPage navigate here".
import 'package:bkni/src/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bkni/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions(
      {super.key,
      required this.name,
      required this.imgUrl,
      required this.price});

  final String name;
  final String imgUrl;
  final String price;
  @override
  State<PaymentOptions> createState() => _PaymentOptions();
}

class _PaymentOptions extends State<PaymentOptions> {
  final int _counter = 0;
  final String imageVector = "assets/images/img_vector.svg";
  // For Payments
  final String paypallogo = "assets/images/logos_paypalpaypal logo svg.svg";
  final String paypalname = "assets/images/fontisto_paypalpaypalsvg.svg";
  final String cardsvg = "assets/images/ion_card-outlinecardsvg.svg";
  final String mtnlogo = "assets/images/mtn.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Choose Payment Method"),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Order Total
              Container(
                height: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF000000), // const Color(0xFF616161),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Order Total",
                            style: TextStyle(color: Color(0xFFFFFFFF))),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Discount \n5$_counter% OFF",
                          style: const TextStyle(color: Color(0xFF616161)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    // Image Section
                    const Center(
                      child: Text("RWF 14,000",
                          style: TextStyle(color: Color(0xFFFFFFFF))),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(2.0, 10.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recommended",
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 1.0,
                      color: Colors.white,
                      child: Container(
                        width: 120,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: SvgPicture.asset(
                                  cardsvg,
                                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "Card Payment",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Visa, MasterCard",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1.0,
                      color: Colors.white,
                      child: Container(
                        width: 120,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(mtnlogo),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "MomoPay",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "MTN",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(2.0, 10.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Alternative methods",
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ConfirmPage(
                                    name: "Some name",
                                    imgUrl: "Some URL",
                                    price: "Some Price")));
                      },
                      child: Card(
                        //elevation: 1.0,
                        color: Colors.white,
                        child: Container(
                          width: 120,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(paypallogo),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "System that supports",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                              const Text(
                                "Online payments.",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*

ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mcgpalette0,
                        ),
                        onPressed: () {
                          /*
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ProductPage(
                                        name: "Some Name",
                                        price: "Some Price",
                                        imgUrl: "Some URL",
                                      )));*/
                        },
                        child: const Text(
                          "GET COUPON",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      */