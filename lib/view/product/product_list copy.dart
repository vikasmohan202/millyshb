// import 'package:flutter/material.dart';
// import 'package:millyshb/view_model/product_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:millyshb/models/product_model.dart';

// class SearchProductScreen extends StatefulWidget {
//   const SearchProductScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchProductScreen> createState() => _SearchProductScreenState();
// }

// class _SearchProductScreenState extends State<SearchProductScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _isSearching = false;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearch(BuildContext context) async {
//     final productProvider = Provider.of<ProductProvider>(context, listen: false);
//     if (_searchController.text.isNotEmpty) {
//       setState(() {
//         _isSearching = true;
//       });
//       await productProvider.searchProduct(_searchController.text, context);
//       setState(() {
//         _isSearching = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Products'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: const InputDecoration(
//                       hintText: 'Search products...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () => _onSearch(context),
//                   child: const Text('Search'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Consumer<ProductProvider>(
//               builder: (context, productProvider, child) {
//                 if (_isSearching) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (productProvider.searchedProduct.isEmpty) {
//                   return const Center(
//                     child: Text('No products found.'),
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: productProvider.searchedProduct.length,
//                   itemBuilder: (context, index) {
//                     final product =
//                         productProvider.searchedProduct[index] as Product;
//                     return ListTile(
//                       leading: product.imageUrl != null
//                           ? Image.network(product.imageUrl!, width: 50)
//                           : const Icon(Icons.image_not_supported),
//                       title: Text(product.name),
//                       subtitle: Text(product.description ?? 'No description'),
//                       trailing: Text('\$${product.price.toString()}'),
//                       onTap: () {
//                         // Handle product tap if needed
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
