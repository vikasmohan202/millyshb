import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/phone_edit_field.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/models/user_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              centerTitle: true,
              title: const Text(
                "Create an account",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        BrandedTextField(
                          controller: _userNameController,
                          labelText: "Username",
                          prefix: const Icon(
                            Icons.person,
                            size: 16,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BrandedTextField(
                            controller: _emailController,
                            labelText: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          child: PhoneEditField(
                            // focus: _focusNode,
                            updatePhone: (value) {
                              setState(() {
                                _mobileNumberController.text = value;
                              });
                            },
                            currentNumber: _mobileNumberController.text,
                            enabled: true,
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: BrandedTextField(
                                controller: _ageController,
                                labelText: "Age",
                                keyboardType: TextInputType.number,
                                prefix: const Icon(
                                  Icons.person,
                                  size: 16,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your age';
                                  }
                                  if (int.tryParse(value) == null ||
                                      int.parse(value) <= 0) {
                                    return 'Please enter a valid age';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 29,
                            ),
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                height: 55,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedGender,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.withOpacity(.15),
                                    filled: true,
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Pallete.disableButtonTextColor),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Pallete
                                              .accentColor), // Change the color as desired
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Pallete
                                              .outLineColor), // Change the color as desired
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    labelText: "Gender",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromRGBO(
                                                103, 103, 103, 1),
                                            fontSize: 12),
                                    contentPadding: const EdgeInsets.all(12),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Icon(
                                        Icons.person,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: 'Male',
                                      child: Text(
                                        'Male',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Pallete.textColor),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Female',
                                      child: Text(
                                        'Female',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Pallete.textColor),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Other',
                                      child: Text(
                                        'Other',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Pallete.textColor),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select your gender';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BrandedTextField(
                          isPassword: true,
                          controller: _passwordController,
                          labelText: "Password",
                          prefix: const Icon(
                            Icons.lock,
                            size: 16,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BrandedTextField(
                          isPassword: true,
                          controller: _confirmPasswordController,
                          labelText: "Confirm Password",
                          prefix: const Icon(
                            Icons.lock,
                            size: 16,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "By clicking the ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextSpan(
                                    text: "Register",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  TextSpan(
                                    text:
                                        " button, you agree to the public offer",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BrandedPrimaryButton(
                          isEnabled: true,
                          name: "Create Account",
                          onPressed: () async {
                            UserModel user = UserModel(
                              token: '',
                              id: "",
                              userName: _userNameController.text,
                              mobileNumber: _mobileNumberController.text,
                              age: _ageController.text,
                              gender: _selectedGender.toString(),
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            await userProvider.userSignup(user, context);
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Already have an account ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(87, 87, 87,
                                          1)), // Set the color for this text
                                ),
                                TextSpan(
                                  text: "Login",
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(53, 53, 100,
                                          1) // Set the color for the clickable text
                                      ),
                                  recognizer: _tapGestureRecognizer
                                    ..onTap = () {
                                      // Handle the click event here
                                      Navigator.of(context).pop();
                                      // You can navigate to another screen or perform any action here
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
              ),
            ),
          );
  }
}
