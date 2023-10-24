import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xirfadle_app/components/product_info.dart';
import 'package:xirfadle_app/screens/cart/cart.dart';
import 'package:xirfadle_app/screens/categories.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:xirfadle_app/screens/user.dart';

import '../providers/cart_provider.dart';

class bottombarscreen extends StatefulWidget {
  const bottombarscreen({Key? key}) : super(key: key);
  @override
  State<bottombarscreen> createState() => _bottombarscreenState();
}

class _bottombarscreenState extends State<bottombarscreen> {
  int _selectedIndex = 0;
  final List _pages = [
    CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white10,
          selectedItemColor: Colors.black87,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _selectedPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: "home"),
            BottomNavigationBarItem(
                icon: Badge(
                  badgeContent: Text(
                    '${cartProvider.getCartItem.length.toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Icon(
                      _selectedIndex == 1 ? IconlyBold.buy : IconlyLight.buy),
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.user2 : IconlyLight.user2),
                label: "User"),
          ]),
    );
  }
}
