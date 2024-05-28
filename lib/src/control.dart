import 'dart:async';

import 'cart.dart';
import 'package:bkni/src/currentprofile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// imports
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:bkni/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'auth.dart';
import 'home.dart';
import 'search.dart';
import 'favorite.dart';
// import 'profile.dart';
import 'notifications.dart';


class ControlPage extends StatefulWidget {
  const ControlPage({super.key, required this.customIndex});
  final int customIndex;
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  String _title = "Bukon!";
  final String logoName = "assets/images/logo_vector.svg";
  final String bukon1 = "assets/src/bukon1.png";

  static int _pageIndex = 0;

  
  @override
  void initState() {
    super.initState();
    _pageIndex = widget.customIndex;
    
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  final PageController _pageController =
      PageController(initialPage: _pageIndex);

  List<DotNavigationBarItem> _dotNavigationBarItems() {
    return <DotNavigationBarItem>[
      DotNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          unselectedColor: const Color(0xFF159954)),
      DotNavigationBarItem(
          icon: const Icon(Icons.search_outlined),
          unselectedColor: const Color(0xFF159954)),
      DotNavigationBarItem(
          icon: const Icon(Icons.favorite_outline),
          unselectedColor: const Color(0xFF159954)),
      DotNavigationBarItem(
          icon: const Icon(Icons.person_outlined),
          unselectedColor: const Color(0xFF159954)),
    ];
  }

  List<Widget> _fourPageViewChildren() {
    return const <Widget>[
      HomePage(title: "Bukon!"),
      SearchPage(),
      FavoritePage(),
      CurrentProfile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor:
            Colors.transparent, // Theme.of(context).colorScheme.inversePrimary,
        leading: Builder(builder: (BuildContext context) {
          return InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: SvgPicture.asset(
              logoName,
              height: 4,
              width: 4,
              fit: BoxFit.scaleDown,
            ),
          );
        }), // Text(widget.title),
        centerTitle: true,
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NotificationsPage()));
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
      ),
      drawer: SafeArea(
        child: Drawer(
          // backgroundColor: Colors.transparent,

          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.close_outlined,
                                color: Colors.amberAccent,
                              )),
                        ),
                        ListTile(
                          leading: SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.network(
                              "${FirebaseAuth.instance.currentUser!.photoURL}",
                            ),
                          ),
                          title: Text(
                            "${FirebaseAuth.instance.currentUser!.displayName}",
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: mcgpalette0),
                          ),
                          subtitle: Text(
                            FirebaseAuth.instance.currentUser != null
                                ? "Active Now"
                                : "Logged Out",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10),
                          ),
                          //trailing: const Icon(Icons.cancel_outlined),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => ControlPage(
                                        customIndex:
                                            FirebaseAuth.instance.currentUser ==
                                                    null
                                                ? 3
                                                : 0,
                                      )),
                            );
                          },
                        ),
                      ]),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CartPage(
                              name: "Cart List",
                              imgUrl: "Cart item from list",
                              price: "State Management - GetX")));
                },
                leading: const Icon(Icons.shopping_cart),
                title: const Text("My Cart"), // Order History
              ),
              const ListTile(
                leading: Icon(Icons.history_rounded),
                title: Text("Order History"), // Order History
              ),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text("Help"), // Order History
              ),
              const ListTile(
                leading: Icon(Icons.settings_outlined),
                title: Text("Settings"),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Sign Out"),
                onTap: () {
                  AuthService().signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _pageIndex = index;
            switch (_pageIndex) {
              case 0:
                {
                  _title = 'Bukon!';
                }
                break;
              case 1:
                {
                  _title = 'Find';
                }
                break;
              case 2:
                {
                  _title = 'Favorites';
                }
                break;
              case 3:
                {
                  _title = 'Account';
                }
                break;
            }
          });
        },
        children: _fourPageViewChildren(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          marginR: const EdgeInsets.only(bottom: 1),
          itemPadding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          items: _dotNavigationBarItems(),
          onTap: (int index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut);
          },
          currentIndex: _pageIndex,
          backgroundColor: const Color(0xFF000000),
          dotIndicatorColor: const Color(0xff000000),
          selectedItemColor: Colors.orangeAccent,
        ),
      ),
    );
  }
}

// Color(0xFF159954) - Bukon! Green
