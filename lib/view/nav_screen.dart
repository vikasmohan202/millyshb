import 'package:flutter/material.dart';
import 'package:millyshb/view/product/checkout.dart';
import 'package:millyshb/view/feed_screen/food_feed_screen.dart';
import 'package:millyshb/view/feed_screen/home_screen.dart';
import 'package:millyshb/view/product/product_list.dart';
import 'package:millyshb/view/product/wish_list.dart';
import 'package:millyshb/view/settings/settings.dart';
import 'package:millyshb/view/product/shopping_bag.dart';
import 'package:millyshb/configs/theme/colors.dart';

class NavScreen extends StatefulWidget {
  final bool isFood;
  const NavScreen({this.isFood = false, super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  bool isFood = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  List<Widget> homeScreenItems = [
    const HomeScreen(),
    ProductList(
      id: "",
      isBackbutton: false,
    ),
    // WishListScreen()
    ShoppingBagScreen(
      isBackButton: false,
    ),
    SettingsScreen()
  ];
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:
            Pallete.accentColor, // Set the color for selected items
        unselectedItemColor:
            Pallete.black87, // Set the color for unselected items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.shopping_cart_outlined,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: 30,
              Icons.settings,
            ),
            label: 'Setting',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
