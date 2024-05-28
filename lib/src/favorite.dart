import 'package:bkni/src/product.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// imports

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: const Text("Favorites"),
        
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
      ), */
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListTile(
              title: const Text("Jordan 4"),
              subtitle: const Text("Updates: Industry People..."),
              trailing: const Icon(Icons.favorite_outline),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductPage(name: "Some Name", price: "Some Price", imgUrl: "Some URL", descriptionTxt: "Some Description",)));
              },
            ),
            ListTile(
              title: const Text("Nike Air OFF WHITE"),
              subtitle: const Text("Updates: Industry People..."),
              trailing: const Icon(Icons.favorite_outline),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
