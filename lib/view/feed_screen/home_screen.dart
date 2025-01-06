import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/cliped_card.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/models/sub_category_model.dart';
import 'package:millyshb/view/login_signup/login_screen.dart';
import 'package:millyshb/view/product/product_list.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/components/image_widget.dart';
import 'package:millyshb/configs/components/product_card.dart';
import 'package:millyshb/view/profile_screen.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/select_store_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  bool isLoading = false;
  final List<String> imgList = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
  ];
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
      if (mounted) setState(() {});
    });
  }

  asyncInit() async {
    setState(() {
      isLoading = true;
    });
    String productId =
        SharedPrefUtil.getValue(recommendedProductsId, "") as String;

    print(productId);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.getSubCategoryList(
        productProvider.selectedCategoryId, context);
    await productProvider.getDiscountedProductList(
        productProvider.selectedCategoryId, context);
    // if (productProvider.subCategory.isNotEmpty) {
    //   await productProvider.getProductList(
    //       (productProvider.subCategory[0] as SubCategory).id, context);
    // }
    // if (productId.isNotEmpty) {
    await productProvider.getRecomProduct("66d006f0f5b1857ad49ceefe", context);
    // }
    // Fetch the subcategories and products
    await Future.wait(productProvider.subCategory.map((item) async {
      await productProvider.getListOfProduct((item as SubCategory).id, context);
    }));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;
    return isLoading
        ? const loadingIndicator()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              forceMaterialTransparency: true,
              centerTitle: true,
              elevation: 0,
              title: const Image(image: AssetImage("assets/images/logo.png")),
              actions: [
                IconButton(
                    onPressed: () {
                      if (isLogin) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ProfilePage();
                        }));
                      } else {
                        _showLoginBottomSheet(context);
                      }
                    },
                    icon: const Icon(Icons.person_outline))
              ],
            ),
            body: Consumer<SelectStoreProvider>(
              builder: (context, provider, child) {
                return cosmeticsFeed(context);
              },
            ),
          );
  }

  Row headingCard(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(23, 23, 37, 1)),
        ),
        const Icon(Icons.chevron_right,
            size: 30, color: Color.fromRGBO(102, 112, 122, 1))
      ],
    );
  }

  SingleChildScrollView cosmeticsFeed(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            BrandedTextField(
                isFilled: false,
                height: 40,
                sufix: const Icon(
                  Icons.mic_outlined,
                  size: 16,
                ),
                prefix: const Icon(
                  Icons.search,
                  size: 16,
                ),
                onChanged: (p0) {},
                controller: _searchController,
                labelText: "Search any product"),

            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productProvider.subCategory.length,
                  itemBuilder: (BuildContext context, item) {
                    SubCategory subCategory =
                        productProvider.subCategory[item] as SubCategory;
                    return ImageWidget(subCategory: subCategory);
                  }),
            ),
            if (productProvider.discountProduct.isNotEmpty)
              const SizedBox(height: 20),
            if (productProvider.discountProduct.isNotEmpty)
              Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: productProvider.discountProduct
                        .map((item) => GestureDetector(
                              onTap: () {
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .selectedSubCategoryId = (productProvider
                                        .subCategory[0] as SubCategory)
                                    .id;
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ProductList(
                                      id: (productProvider.subCategory[0]
                                              as SubCategory)
                                          .id);
                                }));
                                // Navigator.of(context)
                                //     .pushNamed(RoutesName.productList);
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(builder: (context) {
                                //   return ProductList();
                                // }));
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl: (item as Product).image,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                        child: Icon(Icons.error,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 40, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${(item as Product).discount.toString()}% OFF",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          "Now in(Product) \nAll colors",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.37,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Colors.white),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return ProductList(
                                                    id: "",
                                                  );
                                                }));
                                              },
                                              child: const Row(
                                                children: [
                                                  Text(
                                                    "Shop Now ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((urlOfItem) {
                      int index = imgList.indexOf(urlOfItem);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? const Color.fromRGBO(0, 0, 0, 0.9)
                              : const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            if (productProvider.favProduct.isNotEmpty)
              Container(
                color: const Color.fromRGBO(56, 53, 100, 1),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Wishlist",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Products",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              side: const BorderSide(
                                  width: 2, color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Text(
                                  "View All ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            // Container(
            //   height: 230,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 5,
            //       itemBuilder: (BuildContext context, item) {
            //         return Padding(
            //           padding: EdgeInsets.only(right: 8),
            //           child: foodCard(context),
            //         );
            //       }),
            // ),
            if (productProvider.favProduct.isNotEmpty)
              Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  return SizedBox(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productProvider.favProduct.length,
                      itemBuilder: (BuildContext context, item) {
                        Product favProduct = productProvider.favProduct[item];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ProductCard(
                            product: favProduct,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),
            Container(
              color: Colors.white,
              height: 84,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Image.asset("assets/images/product.png"),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top Picks",
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "For You Only !",
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w300,
                                fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Column(
            //   children: productProvider.subCategory.map<Widget>((item) {
            //     return FutureBuilder<List<Product>>(
            //       future: productProvider.getListOfProduct(
            //           (item as SubCategory).id, context),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return Center(
            //               child:
            //                   CircularProgressIndicator()); // Loading indicator
            //         } else if (snapshot.hasError) {
            //           return Center(
            //               child: Text(
            //                   'Error: ${snapshot.error}')); // Handle errors
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
            //                   itemCount: snapshot.data!
            //                       .length, // Use the length of the fetched product list
            //                   itemBuilder: (BuildContext context, index) {
            //                     return Padding(
            //                         padding: EdgeInsets.only(right: 8),
            //                         child: ProductCard(
            //                             product: snapshot.data![
            //                                 index]) // Pass the product data to foodCard
            //                         );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           );
            //         } else {
            //           return Center(
            //               child: Text(
            //                   'No products available')); // Handle the empty state
            //         }
            //       },
            //     );
            //   }).toList(),
            // ),

            // SizedBox(
            //   height: 210,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: productProvider.favProduct.length,
            //       itemBuilder: (BuildContext context, item) {
            //         Product favProduct = productProvider.favProduct[item];
            //         return Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 4),
            //           child: ProductCard(
            //             product: favProduct,
            //           ),
            //         );
            //       }),
            // ),
            if (productProvider.recommendedProducts.isNotEmpty)
              headingCard("Recomended For You "),
            const SizedBox(
              height: 10,
            ),
            Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return SizedBox(
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.recommendedProducts.length,
                    itemBuilder: (BuildContext context, item) {
                      Product recommendedProducts =
                          productProvider.recommendedProducts[item];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ProductCard(
                          product: recommendedProducts,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget focusCard(BuildContext context, SubCategory subCategory) {
    return Container(
      color: const Color.fromRGBO(56, 53, 100, 1),
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  subCategory.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Products",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    side: const BorderSide(width: 2, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .selectedSubCategoryId = subCategory.id;
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ProductList(
                        id: subCategory.id,
                      );
                    }));
                  },
                  child: const Row(
                    children: [
                      Text(
                        "View All ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
