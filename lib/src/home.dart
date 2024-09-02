// ignore_for_file: non_constant_identifier_names

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

class ProductData {
  final String name;
  final double price;
  final String description;
  final List<String> category;
  final String brand;
  final int quantity;
  final String color;
  final String size;
  final String sku;
  final double cost_price;
  final double discount_price;
  final String material;
  final String care_instructions;
  final double shipping_weight;
  final List<String> available_colors;
  final List<String> available_sizes;
  final List<String> tags;
  final String img_url;
  final String brand_uid;
  final DateTime date_added;
  final DateTime last_updated;
  final bool is_active;
  final List<String> additional_images;
  final String bar_code;
  final String lead_time;
  final int product_id;
  final GeoPoint reorder_point;
  final String supplier_info;
  final String tax_category;
  final double weight;

  ProductData({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.brand,
    required this.quantity,
    required this.color,
    required this.size,
    required this.sku,
    required this.cost_price,
    required this.discount_price,
    required this.material,
    required this.care_instructions,
    required this.shipping_weight,
    required this.available_colors,
    required this.available_sizes,
    required this.tags,
    required this.img_url,
    required this.brand_uid,
    required this.date_added,
    required this.last_updated,
    required this.is_active,
    required this.additional_images,
    required this.bar_code,
    required this.lead_time,
    required this.product_id,
    required this.reorder_point,
    required this.supplier_info,
    required this.tax_category,
    required this.weight,
  });

  factory ProductData.fromMap(Map<String, dynamic> map) {
    return ProductData(
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      category: List<String>.from(map['category'] ?? []),
      brand: map['brand'] ?? '',
      quantity: map['quantity'] ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',
      sku: map['sku'] ?? '',
      cost_price: (map['cost_price'] ?? 0).toDouble(),
      discount_price: (map['discount_price'] ?? 0).toDouble(),
      material: map['material'] ?? '',
      care_instructions: map['care_instructions'] ?? '',
      shipping_weight: (map['shipping_weight'] ?? 0).toDouble(),
      available_colors: List<String>.from(map['available_colors'] ?? []),
      available_sizes: List<String>.from(map['available_sizes'] ?? []),
      tags: List<String>.from(map['tags'] ?? []),
      img_url: map['img_url'] ?? '',
      brand_uid: map['brand_uid'] ?? '',
      date_added: (map['date_added'] as Timestamp).toDate(),
      last_updated: (map['last_updated'] as Timestamp).toDate(),
      is_active: map['is_active'] ?? false,
      additional_images: List<String>.from(map['additional_images'] ?? []),
      bar_code: map['bar_code'] ?? '',
      lead_time: map['lead_time'] ?? '',
      product_id: map['product_id'] ?? 0,
      reorder_point: map['reorder_point'] ?? const GeoPoint(0, 0),
      supplier_info: map['supplier_info'] ?? '',
      tax_category: map['tax_category'] ?? '',
      weight: (map['weight'] ?? 0).toDouble(),
    );
  }
}

class Product {
  final String id;
  final ProductData data;

  Product({required this.id, required this.data});
}

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
              const NewCollectionContainer(),

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
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                            child: Image.asset(
                          bukon1,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
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
                            color: Colors.grey[200],
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
                            color: Colors.grey[200],
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
                            color: Colors.grey[200],
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
                            color: Colors.grey[200],
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
                  "New Gadgets & Garmets",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                height: 250,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("products")
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
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (_, index) {
                          final data = ProductData.fromMap(docs[index].data());
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductPage(
                                        product: ProductData.fromMap(
                                            docs[index].data())),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 1.0,
                                //width: double.infinity,
                                // Adjust this width as needed
                                child: Ink(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    //border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 /
                                            9, // Adjust this ratio as needed
                                        child: FadeInImage(
                                          placeholder: AssetImage(imageSample),
                                          image: NetworkImage(data.img_url),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        data.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "RWF ${data.price}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // Add more items here if needed
                                    ],
                                  ),
                                ),
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

              const Divider(
                thickness: 1,
                endIndent: 20,
                indent: 20,
              ),
              // Forum
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Community Forum",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Text(
                      "\"Jordan Cactus is trending after it's release early this June.\"",
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "- User Anonymous",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w800),
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

class NewCollectionContainer extends StatelessWidget {
  // ...
  const NewCollectionContainer({super.key});
  final String mainImg =
      "https://res.cloudinary.com/dezvucnpl/image/upload/v1714929604/mainone_vqrus3.jpg";

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Object?>> productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: productsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle error
        } else if (snapshot.hasData) {
          final List<DocumentSnapshot> docs = snapshot.data!.docs;

          return Container(
            //height: 170.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF000000), // const Color(0xFF616161),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("New Collection",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Discount \n10% OFF\nOn coupons",
                        style: TextStyle(color: Color(0xFF616161)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mcgpalette0,
                          minimumSize: const Size(130, 40),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SortedPage()));
                        },
                        child: const Text(
                          "Shop Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                // Image Section
                Flexible(
                  child: Center(
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
                        child: FadeInImage(
                          placeholder:
                              const AssetImage("assets/images/img_sample.png"),
                          image: NetworkImage(mainImg),
                        ),
                      ), // SvgPicture.asset(mainImg),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
