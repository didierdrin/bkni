import 'package:bkni/src/paymentoptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bkni/src/cartcontroller.dart';
import './cart.dart';
import 'package:bkni/src/favorite_controller.dart';
import 'package:bkni/src/home.dart'; // Import this to use ProductData
import 'package:bkni/color_utils.dart';
// Firebase import
import 'package:cloud_firestore/cloud_firestore.dart';
import "product_service.dart";

class ProductPage extends StatefulWidget {
  final ProductData product;

  const ProductPage({super.key, required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  
 
 
  bool _isFavorite = false;
  String _selectedSize = '';
  String _selectedColor = '';
  int _quantity = 1;

  Future<void> _initializeFavoriteState() async {
    final favoriteController = Get.find<FavoriteController>();
    await favoriteController.loadFavoriteItems();
    setState(() {
      _isFavorite = favoriteController.favoriteItems
          .any((item) => item['name'] == widget.product.name);
    });
  }

  @override
  void initState() {
    super.initState();
   
    _initializeFavoriteState();
    if (widget.product.available_sizes.isNotEmpty) {
      _selectedSize = widget.product.available_sizes[0];
    }
    if (widget.product.available_colors.isNotEmpty) {
      _selectedColor = widget.product.available_colors[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green,
            title: Text(widget.product.name),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                ),
                items: [
                  widget.product.img_url,
                  ...widget.product.additional_images
                ]
                    .map((item) => Image.network(item, fit: BoxFit.cover))
                    .toList(),
              ),
            ),
            actions: [
              IconButton(
                icon:
                    Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () async {
                  final favoriteController = Get.find<FavoriteController>();
                  if (_isFavorite) {
                    // Remove from favorites
                    await favoriteController
                        .removeFromFavorites(widget.product.name);
                  } else {
                    // Add to favorites
                    await favoriteController.addToFavorites({
                      'img_url': widget.product.img_url,
                      'name': widget.product.name,
                      'price': widget.product.price.toString(),
                      'description': widget.product.description,
                      'discount_price': widget.product.discount_price,
                      'available_sizes': widget.product.available_sizes,
                      'available_colors': widget.product.available_colors,
                      'additional_images': widget.product.additional_images,
                      'care_instructions': widget.product.care_instructions,
                      'category': widget.product.category,
                      'brand': widget.product.brand,
                      'quantity': widget.product.quantity,
                      'color': widget.product.color,
                      'size': widget.product.size,
                      'sku': widget.product.sku,
                      'cost_price': widget.product.cost_price,
                      'material': widget.product.material,
                      'shipping_weight': widget.product.shipping_weight,
                      'tags': widget.product.tags,
                      'brand_uid': widget.product.brand_uid,
                      'date_added': widget.product.date_added,
                      'last_updated': widget.product.last_updated,
                      'is_active': widget.product.is_active,
                      'bar_code': widget.product.bar_code,
                      'lead_time': widget.product.lead_time,
                      'product_id': widget.product.product_id,
                      'reorder_point': widget.product.reorder_point,
                      'supplier_info': widget.product.supplier_info,
                      'tax_category': widget.product.tax_category,
                      'weight': widget.product.weight,
                    });
                  }
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'RWF ${widget.product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    if (widget.product.discount_price > 0) ...[
                      const SizedBox(height: 4),
                      Text(
                        'RWF ${widget.product.discount_price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Select Size',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: widget.product.available_sizes
                          .map(
                            (size) => ChoiceChip(
                              label: Text(size),
                              selected: _selectedSize == size,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedSize = size;
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Select Color',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: widget.product.available_colors
                          .map(
                            (color) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = color;
                                });
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ColorUtils.parseColor(color),
                                child: _selectedColor == color
                                    ? Icon(Icons.check, color: Colors.grey[300])
                                    : null,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Quantity',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _quantity > 1
                              ? () {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              : null,
                        ),
                        Text(
                          _quantity.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(widget.product.description),
                    const SizedBox(height: 16),
                    Text(
                      'Care Instructions',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(widget.product.care_instructions),
                    const SizedBox(height: 130),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.find<CartController>().addToCart(
                  widget.product.img_url,
                  widget.product.name,
                  widget.product.price.toString(),
                  _quantity,
                  _selectedSize,
                  _selectedColor,
                );

                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "Added to Cart!"));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Added "${widget.product.name}" to Cart!'), // Use product name for personalization
                    duration:
                        const Duration(seconds: 2), // Set snackbar duration
                    action: SnackBarAction(
                        label: 'View Cart',
                        onPressed: () {
                          // Navigating to CartPage from the Snackbar View Cart.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      CartPage(product: widget.product)));
                        } // Navigate to cart page
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "ADD TO CART",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () {
                // implement buy now. Pass items to Cart| PaymentOptions | Confirm Page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            PaymentOptions(product: widget.product)));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF159954),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "BUY NOW",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => Get.find<CartController>()
                  .addToCart(widget.imgUrl, widget.name, widget.price),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Colors.black,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "ADD TO CART",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CartPage(
                              name: widget.name,
                              price: widget.price,
                              imgUrl: widget.imgUrl,
                            )));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: const Color(0xFF159954),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.shopping_bag_outlined, color: Colors.black,),
                SizedBox(width: 10,),
                Text(
                "BUY NOW",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              ],),
            ),
*/

/* 

bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.find<CartController>().addToCart(
                    widget.product.img_url,
                    widget.product.name,
                    widget.product.price.toString(),
                    _quantity,
                    _selectedSize,
                    _selectedColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('ADD TO CART'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement buy now functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF159954),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('BUY NOW'),
                ),
              ),
            ],
          ),
        ),
      ),


      */
