import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/error_success_dialogue.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/user_api.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  String token;

  UpdatePasswordScreen({required this.token, super.key});
  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Reset Password'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                BrandedTextField(
                    controller: _newPasswordController,
                    labelText: "New Password"),
                const SizedBox(
                  height: 20,
                ),
                BrandedTextField(
                    controller: _currentPasswordController,
                    labelText: "Confirm New Password"),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: BrandedPrimaryButton(
                      isEnabled: true,
                      name: "Update Password",
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        ApiResponse apiResponse = await LoginAPIs()
                            .passwordReset(
                                widget.token, _newPasswordController.text);
                        if (apiResponse.success) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessAndErrorDialougeBox(
                                  subTitle: "Password updated successfully",
                                  isSuccess: true,
                                  title: 'Success',
                                  action: () {},
                                );
                              }).then((value) {
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessAndErrorDialougeBox(
                                  subTitle: "Server Error",
                                  isSuccess: true,
                                  title: 'Server Error',
                                  action: () {},
                                );
                              }).then((value) {
                            setState(() {
                              isLoading = true;
                            });
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ),
        if (isLoading)
          loadingIndicator(
            isTransParent: true,
          )
      ],
    );
  }
}
