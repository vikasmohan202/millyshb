import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/pdf_api.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/user_constext_data.dart';
import 'package:millyshb/models/user_model.dart';
import 'package:millyshb/view/select_store_screen.dart';
import 'package:millyshb/view/splash/welcome_screen.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenState();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), navigate);
  }

  Future<void> navigate() async {
    try {
      // FirebaseMessaging messaging = FirebaseMessaging.instance;
      // String? token = await messaging.getToken();
      // SharedPrefUtil.setValue(fcmToken, token!);
      await _loadInitialData();
      bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;
      if (isLogin) {
        await _loadUserDetails();
        _navigateToScreen(const SelectStoreScreen());
      } else {
        _navigateToScreen(const WelcomeScreen());
      }
    } catch (e) {
      print('Error during navigation: $e');
    }
  }

  Future<void> _loadInitialData() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    //await cartProvider.getSlot("", context);
    await productProvider.getCategoryList(context);
  }

  Future<void> _loadUserDetails() async {
    if (await PDFApi.checkIfFileExists(userDetailsLocalFilePath)) {
      String userJsonString =
          await PDFApi.readFileFromLocalDirectory(userDetailsLocalFilePath);
      Map<String, dynamic> userJson = jsonDecode(userJsonString);
      UserModel user = UserModel.fromJson(userJson);
      Provider.of<UserProvider>(context, listen: false).user = user;
      await UserContextData.setCurrentUserAndFetchUserData(context);
    }
  }

  void _navigateToScreen(Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: const Image(
                    image: AssetImage("assets/images/splash_logo.png"),
                    width: 250.0,
                    height: 250.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
