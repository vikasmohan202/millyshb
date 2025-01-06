// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:millyshb/configs/components/cliped_card.dart';
// import 'package:millyshb/configs/components/constants.dart';
// import 'package:millyshb/configs/components/miscellaneous.dart';
// import 'package:millyshb/configs/components/shared_preferences.dart';
// import 'package:millyshb/configs/routes/routes_names.dart';
// import 'package:millyshb/models/product_model.dart';
// import 'package:millyshb/models/sub_category_model.dart';
// import 'package:millyshb/view/login_signup/login_screen.dart';
// import 'package:millyshb/view/product/product_list.dart';
// import 'package:millyshb/configs/components/branded_text_field.dart';
// import 'package:millyshb/configs/components/image_widget.dart';
// import 'package:millyshb/configs/components/product_card.dart';
// import 'package:millyshb/view/profile_screen.dart';
// import 'package:millyshb/view_model/product_view_model.dart';
// import 'package:millyshb/view_model/select_store_view_model.dart';
// import 'package:millyshb/view_model/user_view_model.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   int _currentIndex = 0;
//   bool isLoading = false;
//   final List<String> imgList = [
//     "assets/images/1.jpg",
//     "assets/images/2.jpg",
//     "assets/images/3.jpg",
//   ];
//   void _showLoginBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return DraggableScrollableSheet(
//           initialChildSize: .8, // Set to 1.0 to cover the full screen initially
//           minChildSize: .1, // Minimum height when partially dragged
//           maxChildSize: 1, // Maximum height when fully dragged
//           expand: true,
//           builder: (context, scrollController) {
//             return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       spreadRadius: 5,
//                       offset: Offset(0, -5),
//                     ),
//                   ],
//                 ),
//                 child: const LoginScreen(
//                   isbottomSheet: true,
//                 ));
//           },
//         );
//       },
//     ).whenComplete(() {
//       if (mounted) setState(() {});
//     });
//     ;
//   }

//   asyncInit() async {
//     setState(() {
//       isLoading = true;
//     });
//     final productProvider =
//         Provider.of<ProductProvider>(context, listen: false);
//     await productProvider.getSubCategoryList(
//         productProvider.selectedCategoryId, context);

//     await productProvider.getProductList(
//         (productProvider.subCategory[0] as SubCategory).id, context);
//     print((productProvider.subCategory[0] as SubCategory).id);
//     await productProvider.getRecomProduct(
//         (productProvider.subCategory[0] as SubCategory).id, context);

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     asyncInit();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;
//     return isLoading
//         ? loadingIndicator()
//         : Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               forceMaterialTransparency: true,
//               centerTitle: true,
//               elevation: 0,
//               title: const Image(image: AssetImage("assets/images/logo.png")),
//               actions: [
//                 IconButton(
//                     onPressed: () {
//                       if (isLogin) {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return const ProfilePage();
//                         }));
//                       } else {
//                         _showLoginBottomSheet(context);
//                       }
//                     },
//                     icon: const Icon(Icons.person_outline))
//               ],
//             ),
//             body: Consumer<SelectStoreProvider>(
//               builder: (context, provider, child) {
//                 return (provider.selectedStore == Store.FOOD)
//                     ? foodFeed(context)
//                     : cosmeticsFeed(context);
//               },
//             ),
//           );
//   }

//   SingleChildScrollView foodFeed(
//     BuildContext context,
//   ) {
//     final productProvider =
//         Provider.of<ProductProvider>(context, listen: false);

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
//                   itemCount: productProvider.subCategory.length,
//                   itemBuilder: (BuildContext context, item) {
//                     SubCategory subCategory =
//                         productProvider.subCategory[item] as SubCategory;
//                     return ImageWidget(subCategory: subCategory);
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
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.asset(
//                       "assets/images/roasted.png",
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       height: 100,
//                     ),
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
//                           const Text(
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
//                           const Column(
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
//                                       color: Color.fromRGBO(102, 112, 122, 1)),
//                                   Text("Elisandra Restaurant",
//                                       style: TextStyle(
//                                           color:
//                                               Color.fromRGBO(102, 112, 122, 1)))
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
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

//   Widget foodCard(BuildContext context, {bool isRecomended = false}) {
//     final productProvider =
//         Provider.of<ProductProvider>(context, listen: false);
//     return GestureDetector(
//       onTap: () {
//         Provider.of<ProductProvider>(context, listen: false)
//                 .selectedSubCategoryId =
//             (productProvider.subCategory[0] as SubCategory).id;

//         Navigator.of(context).pushNamed(RoutesName.productList);
//         // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//         //   return ProductList();
//         // }));
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

//   SingleChildScrollView cosmeticsFeed(BuildContext context) {
//     final productProvider =
//         Provider.of<ProductProvider>(context, listen: false);
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
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
//                                     color: Colors.black,
//                                     fontSize: 12,
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
//                   itemCount: productProvider.subCategory.length,
//                   itemBuilder: (BuildContext context, item) {
//                     SubCategory subCategory =
//                         productProvider.subCategory[item] as SubCategory;
//                     return ImageWidget(subCategory: subCategory);
//                   }),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 200,
//                     autoPlay: true,
//                     enlargeCenterPage: true,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         _currentIndex = index;
//                       });
//                     },
//                   ),
//                   items: imgList
//                       .map((item) => GestureDetector(
//                             onTap: () {
//                               Provider.of<ProductProvider>(context,
//                                       listen: false)
//                                   .selectedSubCategoryId = (productProvider
//                                       .subCategory[0] as SubCategory)
//                                   .id;

//                               Navigator.of(context)
//                                   .pushNamed(RoutesName.productList);
//                               // Navigator.of(context)
//                               //     .push(MaterialPageRoute(builder: (context) {
//                               //   return ProductList();
//                               // }));
//                             },
//                             child: Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(16),
//                                   child: Image.asset(
//                                     item,
//                                     fit: BoxFit.cover,
//                                     width: MediaQuery.of(context).size.width,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.only(top: 40, left: 10),
//                                   child: Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "40-50% OFF",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const Text(
//                                           "Now in(Product) \nAll colors",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.white),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.37,
//                                           child: OutlinedButton(
//                                               style: OutlinedButton.styleFrom(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 16,
//                                                         vertical: 8),
//                                                 side: const BorderSide(
//                                                     width: 2,
//                                                     color: Colors.white),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.of(context).push(
//                                                     MaterialPageRoute(
//                                                         builder: (context) {
//                                                   return ProductList();
//                                                 }));
//                                               },
//                                               child: const Row(
//                                                 children: [
//                                                   Text(
//                                                     "Shop Now ",
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                   Icon(
//                                                     Icons.arrow_forward,
//                                                     color: Colors.white,
//                                                   )
//                                                 ],
//                                               )),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ))
//                       .toList(),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: imgList.map((urlOfItem) {
//                     int index = imgList.indexOf(urlOfItem);
//                     return Container(
//                       width: 8.0,
//                       height: 8.0,
//                       margin: EdgeInsets.symmetric(horizontal: 2.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: _currentIndex == index
//                             ? Color.fromRGBO(0, 0, 0, 0.9)
//                             : Color.fromRGBO(0, 0, 0, 0.4),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             if (productProvider.favProduct.length != 0)
//               Container(
//                 color: const Color.fromRGBO(56, 53, 100, 1),
//                 height: 70,
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 10, top: 10),
//                           child: Text(
//                             "Wishlist",
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10),
//                           child: Text(
//                             "Products",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w300),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.33,
//                         child: OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                               side: const BorderSide(
//                                   width: 2, color: Colors.white),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {},
//                             child: const Row(
//                               children: [
//                                 Text(
//                                   "View All ",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             const SizedBox(height: 10),
//             // Container(
//             //   height: 230,
//             //   child: ListView.builder(
//             //       scrollDirection: Axis.horizontal,
//             //       itemCount: 5,
//             //       itemBuilder: (BuildContext context, item) {
//             //         return Padding(
//             //           padding: EdgeInsets.only(right: 8),
//             //           child: foodCard(context),
//             //         );
//             //       }),
//             // ),
//             if (productProvider.favProduct.length != 0)
//               Consumer<ProductProvider>(
//                 builder: (context, productProvider, child) {
//                   return SizedBox(
//                     height: 210,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: productProvider.favProduct.length,
//                       itemBuilder: (BuildContext context, item) {
//                         Product favProduct = productProvider.favProduct[item];
//                         return Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 4),
//                           child: ProductCard(
//                             product: favProduct,
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             const SizedBox(height: 20),
//             Container(
//               color: Colors.white,
//               height: 84,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Row(
//                   children: [
//                     Image.asset("assets/images/product.png"),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Top Picks",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "For You Only !",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontWeight: FontWeight.w300,
//                                 fontSize: 12),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//           Column(
//   children: productProvider.subCategory.map<Widget>((item) {
//     return FutureBuilder<List<Product>>(
//       future: productProvider.getListOfProduct((item as SubCategory).id,context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator()); // Loading indicator
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}')); // Handle errors
//         } else if (snapshot.hasData) {
//           return Column(
//             children: [
//               focusCard(context, item),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 230,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: snapshot.data!.length, // Use the length of the fetched product list
//                   itemBuilder: (BuildContext context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(right: 8),
//                       child: ProductCard(product: snapshot.data![index])// Pass the product data to foodCard
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         } else {
//           return Center(child: Text('No products available')); // Handle the empty state
//         }
//       },
//     );
//   }).toList(),
// ),


//             // SizedBox(
//             //   height: 210,
//             //   child: ListView.builder(
//             //       scrollDirection: Axis.horizontal,
//             //       itemCount: productProvider.favProduct.length,
//             //       itemBuilder: (BuildContext context, item) {
//             //         Product favProduct = productProvider.favProduct[item];
//             //         return Padding(
//             //           padding: EdgeInsets.symmetric(horizontal: 4),
//             //           child: ProductCard(
//             //             product: favProduct,
//             //           ),
//             //         );
//             //       }),
//             // ),
//             headingCard("Recommended For You "),
//             const SizedBox(
//               height: 10,
//             ),
//             Consumer<ProductProvider>(
//               builder: (context, productProvider, child) {
//                 return SizedBox(
//                   height: 210,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: productProvider.products.length,
//                     itemBuilder: (BuildContext context, item) {
//                       Product recommendedProducts =
//                           productProvider.products[item];
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 4),
//                         child: ProductCard(
//                           product: recommendedProducts,
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget focusCard(BuildContext context, SubCategory subCategory) {
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
//                   subCategory.title,
//                   style: const TextStyle(
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
//                   onPressed: () {
//                     Provider.of<ProductProvider>(context, listen: false)
//                         .selectedSubCategoryId = subCategory.id;
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return ProductList();
//                     }));
//                   },
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

