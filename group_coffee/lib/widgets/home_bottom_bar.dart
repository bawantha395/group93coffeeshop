// home_bottom_bar.dart
import 'package:group_coffee/screens/favouites_screen.dart';
import 'package:group_coffee/homepage.dart';
import 'package:flutter/material.dart';
import 'package:group_coffee/screens/cart_screen.dart';
import 'package:group_coffee/screens/profile_screen.dart';

class HomeBottomBar extends StatelessWidget {
  final Set<String>? favoriteItems;

  HomeBottomBar({this.favoriteItems}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Color(0xFFE57734),
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouritesScreen(favoriteItems: favoriteItems ?? {}),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
