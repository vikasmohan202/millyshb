import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/models/order_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/product/order_details.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    asyncInit();

    super.initState();
  }

  asyncInit() async {
    setState(() {
      isLoading = true;
    });
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.getOrderList(userProvider.user!.id, context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: const Text(
              'My Orders',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Back button functionality
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  productProvider.getOrderList(userProvider.user!.id, context);
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your order here',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: productProvider.orders.length,
            itemBuilder: (context, index) {
              Order order = productProvider.orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    order.items.first.product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(order.status),
                  subtitle: Text(order.items.first.product.name),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return OrderDetailsScreen(
                        order: order,
                      );
                    }));
                  },
                ),
              );
            },
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

class OrderItem {
  final String imageUrl;
  final String title;
  final String status;

  OrderItem({
    required this.imageUrl,
    required this.title,
    required this.status,
  });
}
