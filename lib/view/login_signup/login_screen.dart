import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/view/login_signup/forget_password.dart';
import 'package:millyshb/view/login_signup/sign_up_screen.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/view_model/user_view_model.dart';

import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  final bool isbottomSheet;
  const LoginScreen({super.key, this.isbottomSheet = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  bool isRemember = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: widget.isbottomSheet ? false : true,
              forceMaterialTransparency: true,
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 24.0, fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: " MILLYS",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Pallete.redColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    TextSpan(
                      text: " HB!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Pallete.accentColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    BrandedTextField(
                      controller: _userNameController,
                      labelText: "Username or email",
                      prefix: const Icon(
                        Icons.person,
                        size: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BrandedTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      isPassword: true,
                      onChanged: (value) {
                        if (value.length > 3) {
                          setState(() {});
                        }
                      },
                      prefix: const Icon(
                        Icons.lock,
                        size: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (!widget.isbottomSheet)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const ForgetPasswordScreen();
                              }));
                            },
                            child: Text(
                              "Forget Password?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            )),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    BrandedPrimaryButton(
                      isEnabled: _passwordController.text.isNotEmpty,
                      name: "Login",
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (widget.isbottomSheet) {
                          userProvider.login(_userNameController.text,
                              _passwordController.text, context);
                          Navigator.of(context).pop();
                        } else {
                          await userProvider.login(_userNameController.text,
                              _passwordController.text, context);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SignInButton(
                      Buttons.google,
                      onPressed: () async {
                        String? tokenId = await userProvider.signInWithGoogle();
                        print(tokenId);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      text: "Sign in with Google",
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    if (!widget.isbottomSheet)
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Create an account ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: "Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                recognizer: _tapGestureRecognizer
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const SignUpScreen();
                                    }));
                                  },
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
  }
}
