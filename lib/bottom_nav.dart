
import 'package:everyattire/screens/cart_screens.dart';
import 'package:everyattire/screens/favourites_screen.dart';
import 'package:everyattire/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants/color_constants.dart';


class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // This is to keep track of the selected index in the BottomNavigationBar
  int _currentIndex = 0;

  // List of widgets for each screen
  final List<Widget> _screens = [
    const Center(child: Homepage()),
    Center(child: FavouriteScreen()),
    Center(child: CartScreen()),

  ];

  // Function to handle tap on BottomNavigationBar items
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/home.svg"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/favorites.svg"),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/cart_icon.svg"),
            label: 'Cart',
          ),
        ],
        currentIndex: _currentIndex, // Set the currently selected index
        onTap: _onItemTapped, // Handle tap on items
        selectedItemColor: kPrimaryColor, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
      ),
    );
  }
}