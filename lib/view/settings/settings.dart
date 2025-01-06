import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/view/address/address_list.dart';
import 'package:millyshb/view/login_signup/login_screen.dart';
import 'package:millyshb/view/notification/notifications.dart';
import 'package:millyshb/view/product/order_history.dart';
import 'package:millyshb/view/settings/about_us.dart';
import 'package:millyshb/view/settings/update_password.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserProvider? _userProvider;
  final bool _notificationsEnabled = true;
  bool _isDarkTheme = false;

  void _showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: .8, // Set to 1.0 to cover the full screen initially
          minChildSize: .1, // Minimum height when partially dragged
          maxChildSize: 1, // Maximum height when fully dragged
          expand: true,
          builder: (context, scrollController) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: const LoginScreen(
                  isbottomSheet: true,
                ));
          },
        );
      },
    ).whenComplete(() {
      // Call setState to update the UI after the bottom sheet is closed
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save the reference to the UserProvider here
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _isDarkTheme = SharedPrefUtil.getValue(isDarkTheme, false) as bool;
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NotificationScreen();
              }));
            },
            title: const Text('Notifications'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Saved Address'),
            onTap: () {
              if (isLogin) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressList()),
                );
              } else {
                _showLoginBottomSheet(context);
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Order'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrdersPage()),
              );
            },
          ),
          // ListTile(
          //   title: Text('Update Password'),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => UpdatePasswordScreen()),
          //     // );
          //   },
          // ),
          const Divider(),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Log Out'),
            onTap: () async {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // Replace false with your predicate condition
              );
              SharedPrefUtil.logOut();
              // Ensure the context is not accessed after dispose
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
