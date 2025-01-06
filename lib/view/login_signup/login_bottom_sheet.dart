// import 'package:flutter/material.dart';



// class HomeScreen extends StatelessWidget {
//   void _showLoginBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: LoginScreen(),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _showLoginBottomSheet(context),
//           child: Text('Show Login'),
//         ),
//       ),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Center(
//             child: Image.asset(
//               'assets/flipkart_logo.png', // Replace with your logo asset
//               height: 50,
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Log in for the best experience',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Text('Enter your phone number to continue'),
//           SizedBox(height: 20),
//           TextField(
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'Phone Number',
//               prefixText: '+91 ',
//             ),
//           ),
//           SizedBox(height: 10),
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: () {
//                 // Add functionality to switch to email login
//               },
//               child: Text('Use Email-ID'),
//             ),
//           ),
//           Center(
//             child: Column(
//               children: [
//                 Text(
//                   'By continuing, you agree to Flipkart\'s Terms of Use and Privacy Policy',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add functionality for continue button
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 50),
//                   ),
//                   child: Text('Continue'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
