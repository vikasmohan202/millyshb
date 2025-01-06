import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/cached_image.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/view/product/checkout.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ShoppingBagScreen extends StatefulWidget {
  bool? isBackButton;
  ShoppingBagScreen({this.isBackButton = true, super.key});

  @override
  State<ShoppingBagScreen> createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  final List<String> imgList = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
  ];
  bool isRemoveFromCart = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: widget.isBackButton!,
            backgroundColor: Colors.white,
            forceMaterialTransparency: true,
            centerTitle: true,
            title: const Text(
              "Shopping Bag",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          persistentFooterButtons: (cart.userCart as Cart).products.isNotEmpty
              ? [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BrandedPrimaryButton(
                      isEnabled: true,
                      name: "Proceed",
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const CheckOutScreen();
                        }));
                      },
                    ),
                  )
                ]
              : null,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                (cart.userCart as Cart).products.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: (cart.userCart as Cart).products.length,
                          itemBuilder: (context, item) {
                            final product =
                                (cart.userCart as Cart).products[item];

                            // Inside the ListView.builder widget
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: SizeConfig.screenHeight * 0.21,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          Container(
                                              height:
                                                  SizeConfig.screenHeight * 0.2,
                                              width: 123,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: CustomCachedImage(
                                                imageUrl: product.product.image,
                                                borderRadius: 10.0,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                                placeholder: Container(
                                                  color: Colors.grey[200],
                                                  child: const Icon(
                                                    Icons.image,
                                                    color: Colors.grey,
                                                    size: 50,
                                                  ),
                                                ),
                                                errorWidget: Container(
                                                  color: Colors.grey[200],
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.red,
                                                    size: 50,
                                                  ),
                                                ),
                                              )

                                              // ClipRRect(
                                              //   borderRadius:
                                              //       BorderRadius.circular(10.0),
                                              //   child: Image.network(
                                              //     product.product.image,
                                              //     //"https://res.cloudinary.com/dqhh1rff5/image/upload/v1722194860/Blog/gwvd3q1gi0ctsi43bae8.png", //product.product.image,
                                              //     fit: BoxFit.cover,
                                              //     width: MediaQuery.of(context)
                                              //         .size
                                              //         .width,
                                              //   ),
                                              // ),
                                              ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.494,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: SizedBox(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.3,
                                                          child: Text(
                                                            product
                                                                .product.name,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () async {
                                                          setState(() {
                                                            isRemoveFromCart =
                                                                true;
                                                          });

                                                          await cartProvider
                                                              .removeFromCart(
                                                                  userProvider
                                                                      .user!.id,
                                                                  product
                                                                      .product,
                                                                  context);
                                                          setState(() {
                                                            isRemoveFromCart =
                                                                false;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                // Show discounted price if available
                                                if (product.product.discount !=
                                                    0)
                                                  Text(
                                                    "\$ ${((product.product.price) * product.quantity).toStringAsFixed(2)}",
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          187, 187, 187, 1),
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                // Show final price
                                                Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        242, 242, 242, 1),
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Center(
                                                    child: Text(
                                                      "\$ ${((product.product.price - product.product.discount) * product.quantity).toStringAsFixed(2)}",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (product.quantity ==
                                                            1) {
                                                          setState(() {
                                                            isRemoveFromCart =
                                                                true;
                                                          });

                                                          await cartProvider
                                                              .removeFromCart(
                                                                  userProvider
                                                                      .user!.id,
                                                                  product
                                                                      .product,
                                                                  context);
                                                          setState(() {
                                                            isRemoveFromCart =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            isRemoveFromCart =
                                                                true;
                                                          });
                                                          await cartProvider
                                                              .decreaseProductQuantity(
                                                                  userProvider
                                                                      .user!.id,
                                                                  product
                                                                      .product,
                                                                  context);
                                                          setState(() {
                                                            isRemoveFromCart =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenHeight *
                                                            0.07,
                                                        height: SizeConfig
                                                                .screenWidth *
                                                            0.1,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors
                                                              .grey, // Background color for the container
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        child: (product
                                                                    .quantity ==
                                                                1)
                                                            ? const Icon(
                                                                Icons.delete)
                                                            : const Icon(
                                                                Icons.remove),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig
                                                              .screenHeight *
                                                          0.07,
                                                      height: SizeConfig
                                                              .screenWidth *
                                                          0.1,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        color: Colors
                                                            .white, // Background color for the container
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          product.quantity
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        setState(() {
                                                          isRemoveFromCart =
                                                              true;
                                                        });
                                                        await cartProvider
                                                            .increaseProductQuantity(
                                                                userProvider
                                                                    .user!.id,
                                                                product.product,
                                                                context);
                                                        setState(() {
                                                          isRemoveFromCart =
                                                              false;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenHeight *
                                                            0.07,
                                                        height: SizeConfig
                                                                .screenWidth *
                                                            0.1,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors
                                                              .grey, // Background color for the container
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                            Icons.add),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: Text(
                            "No Product is added",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        if (isRemoveFromCart)
          loadingIndicator(
            isTransParent: true,
          )
      ],
    );
  }

  Container focusCard(BuildContext context, String name) {
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
                  name,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
