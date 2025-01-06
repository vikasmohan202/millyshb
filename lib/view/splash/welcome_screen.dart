import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/view/login_signup/login_screen.dart';
import 'package:millyshb/view/login_signup/sign_up_screen.dart';
import 'package:millyshb/view/select_store_screen.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';

// import 'package:animated_text/animated_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  WelcomeScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.15),
                    child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const Image(
                          image: AssetImage("assets/images/welcome_logo.png"),
                          width: 250.0,
                          height: 250.0,
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Start Shopping",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    ' "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."',
                    textAlign: TextAlign.center, // Align text center
                    style: TextStyle(
                      color: Color.fromRGBO(168, 168, 169, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BrandedPrimaryButton(
                      isEnabled: true,
                      name: "Login",
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  BrandedPrimaryButton(
                      isUnfocus: true,
                      isEnabled: true,
                      name: "Sign Up",
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const SignUpScreen();
                        }));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(
                                0, 0, 0, 1), // Adjust color as needed
                            thickness: 1, // Adjust thickness as needed
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(
                                  0, 0, 0, 1), // Adjust color as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(
                                0, 0, 0, 1), // Adjust color as needed
                            thickness: 1, // Adjust thickness as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      SharedPrefUtil.setValue(isLogedIn, false);

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SelectStoreScreen();
                      }));
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      backgroundColor:
                          Colors.transparent, // Transparent background
                      // Text color
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Pallete.accentColor
                          // decoration: TextDecoration.underline,
                          ),
                      side: const BorderSide(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded border
                      ),
                    ),
                    child: const Text(
                      "Skip without Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Pallete.accentColor
                          // decoration: TextDecoration.underline,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
