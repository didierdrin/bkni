import 'package:bkni/colors.dart';
// import 'package:bkni/src/favorite.dart';
import 'package:bkni/src/product.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
// imports
// import 'search.dart';
// import 'notifications.dart';
// import 'profile.dart';
// import 'package:bkni/colors.dart';
import 'branded.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'model.dart';
// Database
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _counter = 0;
  final String logoName = "assets/images/logo_vector.svg";
  final String imageName = "assets/images/play_store_512.png";
  final String imageSample = "assets/images/img_sample.png";
  final String imageVector = "assets/images/img_vector.svg";
  final String mainImgTwo = "assets/images/mainone.jpeg";
  final String mainImg =
      "https://res.cloudinary.com/dezvucnpl/image/upload/v1714929604/mainone_vqrus3.jpg";
  //final String mainjpeg = "assets/images/main.jpeg";
  // For Branded
  final String fragileSvg = "assets/images/fra_black-removebg-preview.svg";
  final String isunzuSvg = "assets/images/isunzu-removebg-preview.svg";
  final String moshionsSvg = "assets/images/moshions-removebg-preview.svg";
  final String aflimbaSvg = "assets/images/aflimba-removebg-preview.svg";
  // ------
  final String fragile = "assets/images/fragile.png";
  final String aflimba = "assets/images/aflimba.png";
  final String isunzu = "assets/images/isunzu.png";
  final String moshions = "assets/images/moshions.png";
  // ------
  final String bukon1 = "assets/src/bukon1.png";
  final String nike = "assets/src/nike.png";
  final String adidas = "assets/src/adidas.png";
  final String puma = "assets/src/puma.png";
  final String reebok = "assets/src/reebok.png";
  // For Payments
  final String paypallogo = "assets/images/logos_paypalpaypal logo svg.svg";
  final String paypalname = "assets/images/fontisto_paypalpaypal.svg";
  final String cardimg = "assets/images/ion_card-outlinecardsvg.svg";

  // final _formKey = GlobalKey<FormState>(); -- It was for search form

  @override
  Widget build(BuildContext context) {
    // CollectionReference inventory = FirebaseFirestore.instance.collection("inventory");
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // New Collection Container
              Container(
                height: 168.0,
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
                        const Text("New Collection",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            )),
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mcgpalette0,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductPage(
                                          name: "Z09 Custom Imigongo",
                                          price: "RWF18,000",
                                          imgUrl: mainImg,
                                          descriptionTxt: "Some Description",
                                        )));
                          },
                          child: const Text(
                            "Shop Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    // Image Section
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20.0)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20.0)),
                          child: Image.network(
                            mainImg,
                            fit: BoxFit.fill,
                          ),
                        ), // SvgPicture.asset(mainImg),
                      ),
                    ),
                  ],
                ),
              ),

              // Row Brand
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Brand",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Hard Coded Containers. ListBuilder
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SortedPage()));
                      },
                      child: Container(
                        width: 82.0,
                        height: 82.0,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                            child: Image.asset(
                          bukon1,
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SortedPage()));
                      },
                      child: Container(
                        width: 82.0,
                        height: 82.0,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                            child: SvgPicture.asset(
                          aflimbaSvg,
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SortedPage()));
                      },
                      child: Container(
                        width: 82.0,
                        height: 82.0,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                          child: Text(
                            "fra.",
                            style: GoogleFonts.playfairDisplay(
                                textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SortedPage()));
                      },
                      child: Container(
                        width: 82.0,
                        height: 82.0,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SvgPicture.asset(
                            isunzuSvg,
                            fit: BoxFit.fill,
                            height: 80,
                            width: 80,
                          ),
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SortedPage()));
                      },
                      child: Container(
                        width: 82.0,
                        height: 82.0,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                            child: SvgPicture.asset(
                          moshionsSvg,
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),

              // Row New Shoes
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "New Shoes",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                height: 250,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("inventory")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;
                      return GridView.builder(
                        shrinkWrap: false,
                        itemCount: docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (_, index) {
                          final data = docs[index].data();
                          // debugPrint(data.toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductPage(
                                            name: data['name'],
                                            price: data['price'].toString(),
                                            imgUrl: data['img_url'],
                                            descriptionTxt: data["description"],
                                          )));
                            },
                            child: Ink(
                              // width: 144.0,
                              // height: 400.0,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: 95,

                                    ///140 total
                                    width: 144,
                                    // decoration: const BoxDecoration(
                                    //color: Color(0xFFD9D9D9),
                                    // ),
                                    child: Image.network(
                                      data['img_url'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 144,
                                    child: Row(
                                      children: [
                                        /// Nike SB 42 \nRWF83,990"
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                data['name'],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                "RWF ${data['price']}",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // const Spacer(),
                                        // const Icon(Icons.star_outline),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 0, 0),
                                          child: Text("4.6"),
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
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      /*
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // FloatingActionButton Navigation Bar
      
      
      */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*
UI New shoes widget

Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Hard Coded Containers. ListBuilder
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProductPage()));
                      },
                      child: Ink(
                        // width: 144.0,
                        height: 198.0,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              height: 158,
                              width: 144,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  imageVector,
                                  colorFilter: const ColorFilter.mode(
                                      Color(0x87000000), BlendMode.srcIn),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Expanded(
                              child: SizedBox(
                                height: 40,
                                width: 144,
                                /*
                                decoration: const BoxDecoration(
                                    color: Colors.transparent), */
                                child: Row(
                                  children: [
                                    Text("Nike SB 42 \nRWF83,990"),
                                    Spacer(),
                                    Icon(Icons.star_outline),
                                    Text("4.6")
                                  ],
                                ),
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

*/
