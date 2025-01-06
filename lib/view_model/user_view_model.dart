import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/pdf_api.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/user_constext_data.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/google_auth.dart';
import 'package:millyshb/configs/network/server_calls/user_api.dart';
import 'package:millyshb/models/user_model.dart';
import 'package:millyshb/view/feed_screen/home_screen.dart';
import 'package:millyshb/view/select_store_screen.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  final GoogleAuth _googleAuth = GoogleAuth();

  // Getter to retrieve the current user
  UserModel? get user => _user;

  // Getter to check loading state

  // Setter to update the current user
  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  login(String userNameOrEmail, String password, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response =
        await LoginAPIs().login(userNameOrEmail, password);
    if (response.success) {
      SharedPrefUtil.setValue(isLogedIn, true);

      String token = response.data['token'];

      SharedPrefUtil.setValue(userToken, token);

      _user = UserModel.fromJson(response.data['data']);
      await UserContextData.setCurrentUserAndFetchUserData(context);

      PDFApi.saveFileToLocalDirectory(
          jsonEncode(_user!.toJson()), userDetailsLocalFilePath);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const SelectStoreScreen();
      }));
    } else {
      _showSnackBar(context, 'Internal server error', Colors.red);
    }
    _setLoading(false);
  }

  userSignup(UserModel user, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response = await LoginAPIs().signUp(user);
    if (response.success) {
      _showSnackBar(context, 'User Registered', Colors.green);
      Navigator.of(context).pop();
    } else {
      _showSnackBar(context, "Invalid email/username or password", Colors.red);
    }
    _setLoading(false);
  }

  verifyToken(
    String token,
  ) async {
    _setLoading(true);
    ApiResponseWithData response = await LoginAPIs().verifyToken(token);
    if (response.success) {
      //_showSnackBar(context, 'User Registered', Colors.green);
      // Navigator.of(context).pop();
    } else {
      // _showSnackBar(context, "Invalid email/username or password", Colors.red);
    }
    _setLoading(false);
  }

  Future<String?> signInWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Obtain the Google authentication tokens
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the Google credentials
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Get the ID token to send to your Node.js backend
      final idToken = await user?.getIdToken();
      await verifyToken(
        idToken!,
      );

      return idToken;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  // Future<void> loginWithGoogle(BuildContext context) async {
  //   User? user = await _googleAuth.signInWithGoogle();

  //   if (user != null) {
  //       // final GoogleSignInAuthentication googleAuth = await user!;

  //     // Retrieve the ID token
  //     final String? idToken = googleAuth.idToken;
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const HomeScreen()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Google sign-in failed.')),
  //     );
  //   }
  // }
  // Future<void> loginWithGoogle(BuildContext context) async {
  //   try {
  //     // Initialize Google sign-in
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser != null) {
  //       // Authenticate with Google
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  //       var response =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       print(response);
  //       // Retrieve the ID token\
  //       final String? idToken = googleAuth.idToken;

  //       if (idToken != null) {
  //         // Navigate to the HomeScreen
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const HomeScreen()),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Unable to retrieve token.')),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Google sign-in failed.')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    });
  }
}
