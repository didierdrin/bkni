// ignore_for_file: non_constant_identifier_names

import 'package:bkni/colors.dart';
// import 'package:bkni/src/favorite.dart';
import 'package:bkni/src/cartcontroller.dart';
import 'package:bkni/src/cart.dart';
import 'package:bkni/src/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("products").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final docs = snapshot.data!.docs;
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const NewCollectionContainer(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Custom Garments",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 80.0),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final data =
                          ProductData.fromMap(docs[index].data());
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductPage(
                                  product: ProductData.fromMap(
                                      docs[index].data()),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 1.0,
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Ink(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: FadeInImage(
                                            placeholder:
                                                AssetImage(imageSample),
                                            image: NetworkImage(data.img_url),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            imageErrorBuilder: (context,
                                                error, stackTrace) {
                                              return Image.asset(
                                                imageSample,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "RWF ${data.price.toStringAsFixed(0)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Expanded(
                                              child: Text(
                                                data.description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        Get.find<CartController>().addToCart(
                                          data.img_url,
                                          data.name,
                                          data.price.toString(),
                                          1,
                                          data.available_sizes.isNotEmpty
                                              ? data.available_sizes.first
                                              : '',
                                          data.available_colors.isNotEmpty
                                              ? data.available_colors.first
                                              : '',
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Added "${data.name}" to cart'),
                                            action: SnackBarAction(
                                              label: 'View Cart',
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => CartPage(
                                                      product: data,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          size: 22,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: docs.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NewCollectionContainer extends StatelessWidget {
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
