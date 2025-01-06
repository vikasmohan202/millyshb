// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:millyshb/screens/product_details_screens.dart';
// import 'package:millyshb/configs/components/branded_text_field.dart';
// import 'package:millyshb/configs/components/cliped_card.dart';
// import 'package:millyshb/configs/components/image_widget.dart';
// import 'package:millyshb/configs/components/product_card.dart';

// class FoodFeedscreen extends StatefulWidget {
//   const FoodFeedscreen({super.key});

//   @override
//   State<FoodFeedscreen> createState() => _FoodFeedscreenState();
// }

// class _FoodFeedscreenState extends State<FoodFeedscreen> {
//   final TextEditingController _searchController = TextEditingController();
//   int _currentIndex = 0;

//   final List<String> imgList = [
//     "assets/images/1.jpg",
//     "assets/images/2.jpg",
//     "assets/images/3.jpg",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Image(image: AssetImage("assets/images/logo.png")),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline))
//         ],
//       ),
//       body: foodFeed(context),
//     );
//   }

//   SingleChildScrollView foodFeed(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BrandedTextField(
//                 isFilled: false,
//                 height: 40,
//                 sufix: const Icon(
//                   Icons.mic_outlined,
//                   size: 16,
//                 ),
//                 prefix: const Icon(
//                   Icons.search,
//                   size: 16,
//                 ),
//                 controller: _searchController,
//                 labelText: "Search any product"),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "All Featured",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   width: 140,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         height: 24,
//                         width: 61,
//                         child: OutlinedButton(
//                           onPressed: () {},
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.only(left: 12),
//                             backgroundColor: Colors.white,
//                             side: const BorderSide(color: Colors.transparent),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           child: const Row(
//                             children: [
//                               Text(
//                                 "Sort",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                               Icon(
//                                 Icons.sort,
//                                 color: Colors.black,
//                                 size: 16,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       SizedBox(
//                         height: 24,
//                         width: 61,
//                         child: OutlinedButton(
//                           onPressed: () {},
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.only(left: 12),
//                             backgroundColor: Colors.white,
//                             side: const BorderSide(color: Colors.transparent),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           child: const Row(
//                             children: [
//                               Text(
//                                 "Filter",
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                               Icon(
//                                 Icons.filter_alt_outlined,
//                                 color: Colors.black,
//                                 size: 16,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 100,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, item) {
//                     return const ImageWidget();
//                   }),
//             ),
//             const SizedBox(height: 10),
//             headingCard("Discount guaranteed!"),
//             const SizedBox(height: 10),
//             Container(
//               height: 230,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, item) {
//                     return Padding(
//                       padding: EdgeInsets.only(right: 8),
//                       child: foodCard(context),
//                     );
//                   }),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * 0.62),
//                   child: Image.asset(
//                     "assets/images/roasted.png",
//                     width: MediaQuery.of(context).size.width * 0.6,
//                     height: 100,
//                   ),
//                 ),
//                 CustomShapeContainer(),
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 8, top: 8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Some interesting events \nof YUMMY FOOD',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             SizedBox(
//                               height: 28,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   // Add your onPressed code here!
//                                 },
//                                 child: Text('Discover'),
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             headingCard("What's delicious around here?"),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 230,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, item) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: foodCard(context),
//                     );
//                   }),
//             ),
//             Container(
//               height: 180,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, item) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 123,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(
//                                   15.0), // Adjust the radius as needed
//                               child: Image.network(
//                                 "https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?s=1024x1024&w=is&k=20&c=VaRsD5pHXDCMcwcAsOGaaBadptx0nHaJUuVKpyWaq3A=",
//                                 fit: BoxFit
//                                     .cover, // This will ensure the image covers the entire container
//                                 width: MediaQuery.of(context)
//                                     .size
//                                     .width, // Ensure the image takes the full width
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             "Frozen Food",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//             ),
//             headingCard("Highlights of March"),
//             SizedBox(
//               height: 10,
//             ),
//             const SizedBox(height: 10),
//             Container(
//               height: 230,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, item) {
//                     return Padding(
//                       padding: EdgeInsets.only(right: 8),
//                       child: foodCard(context),
//                     );
//                   }),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             headingCard("Nearby Restaurants"),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 220,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, item) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.asset(
//                               "assets/images/1.jpg",
//                               fit: BoxFit.cover,
//                               width: 192,
//                               height: 156,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Elisandra Restaurant ",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(Icons.location_on_outlined,
//                                       color:
//                                           Color.fromRGBO(102, 112, 122, 1)),
//                                   Text("Elisandra Restaurant",
//                                       style: TextStyle(
//                                           color: Color.fromRGBO(
//                                               102, 112, 122, 1)))
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             headingCard("Recommended For You "),
//             SizedBox(
//               height: 10,
//             ),
//             foodCard(context, isRecomended: true)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget foodCard(BuildContext context, {bool isRecomended = false}) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//           return ProductDetailsScreen();
//         }));
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.asset(
//                   "assets/images/1.jpg",
//                   fit: BoxFit.cover,
//                   width: isRecomended ? MediaQuery.of(context).size.width : 192,
//                   height: 156,
//                 ),
//               ),
//               if (!isRecomended)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, left: 5),
//                   child: Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 107,
//                           height: 28,
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(53, 53, 100, 1),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Center(
//                             child: const Text(
//                               "4% off your order ",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: 140,
//                     left: isRecomended
//                         ? MediaQuery.of(context).size.width * 0.6
//                         : 80),
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 107,
//                         height: 28,
//                         decoration: BoxDecoration(
//                           color: Color.fromRGBO(53, 53, 100, 1),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "4% off your order ",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Pizza Hut",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.44,
//                     child: Row(
//                       children: [
//                         Text(
//                           "1.5 Km |",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromRGBO(120, 130, 138, 1)),
//                         ),
//                         Icon(
//                           Icons.star,
//                           size: 15,
//                           color: Color.fromRGBO(254, 204, 99, 1),
//                         ),
//                         Text(
//                           "1.4 (1.2k)",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromRGBO(120, 130, 138, 1)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(
//                     Icons.favorite_outline,
//                     color: Color.fromRGBO(245, 131, 94, 1),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Row headingCard(String text) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           text,
//           style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Color.fromRGBO(23, 23, 37, 1)),
//         ),
//         Icon(Icons.chevron_right,
//             size: 30, color: Color.fromRGBO(102, 112, 122, 1))
//       ],
//     );
//   }

//   Container focusCard(BuildContext context, String name) {
//     return Container(
//       color: const Color.fromRGBO(56, 53, 100, 1),
//       height: 70,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 10, top: 10),
//                 child: Text(
//                   name,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: Text(
//                   "Products",
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w300),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.33,
//               child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     side: const BorderSide(width: 2, color: Colors.white),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: const Row(
//                     children: [
//                       Text(
//                         "View All ",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
