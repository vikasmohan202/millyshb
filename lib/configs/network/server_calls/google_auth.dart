// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // // Sign up with Email and Password
  // Future<User?> signUpWithEmailPassword(String email, String password) async {
  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return userCredential.user;
  //   } catch (e) {
  //     print("Sign-up error: $e");
  //     return null;
  //   }
  // }

  // // Sign in with Email and Password
  // Future<User?> signInWithEmailPassword(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return userCredential.user;
  //   } catch (e) {
  //     print("Sign-in error: $e");
  //     return null;
  //   }
  // }

  // // Google Sign-In
  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       return null; // User cancelled the sign-in
  //     }
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } catch (e) {
  //     print("Google Sign-In error: $e");
  //     return null;
  //   }
  // }

  // Future<void> signUpWithEmail(String email, String password,
  //     BuildContext context, String phoneNumber) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     // Send email verification
  //     User? user = _auth.currentUser;
  //     if (user != null && !user.emailVerified) {
  //       await user.sendEmailVerification();
  //       if (user.uid != '') {}
  //     }
  //     // await user!.reload();
  //     // print(user.emailVerified);
  //   } catch (e) {
  //     // Handle error as needed
  //   }
  // }

  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    // try {
    //   await _auth
    //       .signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   )
    //       .then((value) async {
    //     value.user!.uid;
    //   });
    // } catch (e) {
    //   debugPrint("Error signing in with email and password: $e");
    //   // Handle error as needed
    // }
  }

  // Sign out
  Future<void> signOut() async {
    // await _auth.signOut();
  }
}
