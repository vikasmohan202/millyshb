import 'package:flutter/material.dart';
import 'package:millyshb/view/about_us.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    width: 200,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const SizedBox(
          height: 50,
        ),
        // DrawerHeader(
        //   decoration: BoxDecoration(
        //     color: Colors.blue,
        //   ),
        //   child: Text(
        //     'Drawer Header',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 24,
        //     ),
        //   ),
        // ),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            // Handle the Home tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Product'),
          onTap: () {
            // Handle the Settings tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('About Us'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AboutUs();
            })); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Support'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Blogs'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.pop(context); // Close the drawer
          },
        ),
      ],
    ),
  );
}
