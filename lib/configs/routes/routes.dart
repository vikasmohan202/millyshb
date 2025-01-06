import 'package:flutter/material.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/view/feed_screen/home_screen.dart';
import 'package:millyshb/view/login_signup/login_screen.dart';
import 'package:millyshb/view/product/product_details_screen.dart';
import 'package:millyshb/view/product/product_list.dart';
import 'package:millyshb/view/product/select_slot.dart';
import 'package:millyshb/view/product/shopping_bag.dart';
import 'package:millyshb/view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      // case RoutesName.productList:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => ProductList());

      case RoutesName.shoppingBag:
        return MaterialPageRoute(
            builder: (BuildContext context) => ShoppingBagScreen());
      case RoutesName.selectSlot:
        return MaterialPageRoute(
            builder: (BuildContext context) => SelectSlots(
                  duration: const [],
                  serviceId: const [],
                ));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
