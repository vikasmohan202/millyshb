import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/login_signup/login_screen.dart';
import 'package:millyshb/view/product/checkout.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailsScreen extends StatefulWidget {
  Product product;

  ProductDetailsScreen({required this.product, super.key});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentIndex = 0;
  int _quantity = 1; // Initial quantity
  bool isInCart = false;
  bool isStackLoading = false;

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;

    final List<String> imgList = [
      widget.product.image,
    ];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    bool inCart = false;
    for (var cartProduct in (cart.userCart as Cart).products) {
      if (cartProduct.product.id == widget.product.id) {
        inCart = true;
      }
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Product Name"),
            centerTitle: true,
            actions: [
              badges.Badge(
                ignorePointer: true,
                badgeContent: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return Center(
                      child: Text(
                        (cart.userCart as Cart).products.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                showBadge: (cart.userCart as Cart).products.isNotEmpty,
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RoutesName.shoppingBag);
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ],
          ),
          persistentFooterButtons: [
            Row(
              children: [
                Expanded(
                  child: BrandedPrimaryButton(
                    isUnfocus: true,
                    isEnabled: true,
                    name: inCart ? "Go to cart" : "Add to cart",
                    onPressed: () async {
                      //  if (isLogin) {
                      setState(() {
                        isStackLoading = true;
                      });
                      if (inCart) {
                        Navigator.of(context).pushNamed(RoutesName.shoppingBag);
                      } else {
                        if (isLogin) {
                          await cart.addTOCart(
                              widget.product, userProvider.user!.id, context);
                        } else {
                          await cart.addTOCart(widget.product, '', context);
                        }
                      }
                      setState(() {
                        isStackLoading = false;
                      });
                      // } else {
                      //   _showLoginBottomSheet(context);
                      // }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BrandedPrimaryButton(
                    isEnabled: true,
                    name: "Buy Now",
                    onPressed: () {
                      if (isLogin) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const CheckOutScreen();
                        }));
                        setState(() {
                          isStackLoading = false;
                        });
                      } else {
                        _showLoginBottomSheet(context);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: SizeConfig.screenHeight * .42,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: imgList
                            .map((item) => GestureDetector(
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          imageUrl: item,
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: SizeConfig.screenHeight * 0.4,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
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
                  const SizedBox(height: 20),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        color: Pallete.accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(widget.product.description),
                  // SizedBox(height: 20),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Lorem Ipsum",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Lorem Ipsum")
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Lorem Ipsum",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Lorem Ipsum")
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Lorem Ipsum",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Lorem Ipsum")
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        height: 30,
                        width: 84,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(0),
                        child: Center(
                          child: Text(
                            "\$${widget.product.price}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (isInCart)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.remove, color: Colors.black),
                              onPressed: () {
                                // cart.removeProduct(product);

                                setState(() {
                                  if (_quantity > 1) {
                                    _quantity--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '$_quantity',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.black),
                              onPressed: () {
                                // cart.addProduct(product);

                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        if (isStackLoading)
          loadingIndicator(
            isTransParent: true,
          )
      ],
    );
  }
}
