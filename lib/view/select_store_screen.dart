import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/store_card.dart';
import 'package:millyshb/models/category_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class SelectStoreScreen extends StatefulWidget {
  const SelectStoreScreen({super.key});

  @override
  State<SelectStoreScreen> createState() => _SelectStoreScreenState();
}

class _SelectStoreScreenState extends State<SelectStoreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return productProvider.isLoading
        ? loadingIndicator()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              forceMaterialTransparency: true,
              centerTitle: true,
              title: const Text(
                "Select Store",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    StoreCard(
                      category:
                          (productProvider.category[0] as ProductCategory),
                      isFood: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StoreCard(
                        category:
                            (productProvider.category[1] as ProductCategory),
                        isFood: false),
                  ],
                ),
              ),
            ),
          );
  }
}
