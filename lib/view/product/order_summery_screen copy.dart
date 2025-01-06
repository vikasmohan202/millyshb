import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/models/delivery_slot_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/payment/payment_screen.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class OrderSummery extends StatefulWidget {
  DeliverySlot deliverySlot;
  OrderSummery({required this.deliverySlot, super.key});

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
  bool isLoading = false;
  double price = 0.0;
  double totelPrice = 0.0;
  final TextEditingController _codeController = TextEditingController();
  addPayment() {
    setState(() {
      isLoading = true;
    });
    final cart = Provider.of<CartProvider>(context, listen: false);

    for (CartItem product in (cart.userCart as Cart).products) {
      price = price + (product.product.price - product.product.discount);
    }
    totelPrice = price + int.parse(widget.deliverySlot.price) + 12;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    addPayment();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                "Summery",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: BrandedPrimaryButton(
                    isEnabled: true,
                    name: "Procced to Payment",
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PaymentScreen(
                          deliverySlot: widget.deliverySlot,
                          price: totelPrice,
                        );
                      }));
                    }),
              )
            ],
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 0,
                      child: SizedBox(
                        width: SizeConfig.blockSizeVertical * 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/coupon.png"),
                                  const SizedBox(width: 8),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Add Gift Card or Promo Code",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Text(
                                    "Select",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: cart.lstCoupon.map((coupon) {
                                  return ListTile(
                                    title: Text(coupon.code),
                                    subtitle:
                                        Text(coupon.discountValue.toString()),
                                  );
                                }).toList(),
                              )
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: BrandedTextField(
                              //           height: 45,
                              //           isEnabled: true,
                              //           controller: _codeController,
                              //           labelText: "Enter Code"),
                              //     ),
                              //     const SizedBox(
                              //       width: 20,
                              //     ),
                              //     Expanded(
                              //       child: BrandedPrimaryButton(
                              //           name: "Apply", onPressed: () {}),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: (cart.userCart as Cart).products.map((product) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: SizeConfig.screenHeight * 0.18,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Container(
                                      height: SizeConfig.screenHeight * 0.2,
                                      width: 123,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          product.product.image,
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width:
                                                SizeConfig.screenWidth * 0.494,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(top: 10),
                                                  child: SizedBox(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.3,
                                                    child: Text(
                                                      product.product.name,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // IconButton(
                                                //   padding: EdgeInsets.zero,
                                                //   icon: const Icon(
                                                //       Icons.delete,
                                                //       color: Colors.red),
                                                //   onPressed: () async {
                                                //     // setState(() {
                                                //     //   isRemoveFromCart =
                                                //     //       true;
                                                //     // });

                                                //     // await cartProvider
                                                //     //     .removeFromCart(
                                                //     //         userProvider
                                                //     //             .user!.id,
                                                //     //         product.product,
                                                //     //         context);
                                                //     // setState(() {
                                                //     //   isRemoveFromCart =
                                                //     //       false;
                                                //     // });
                                                //   },
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          if (product.product.discount != 0)
                                            Text(
                                              "\$ ${product.product.price + product.product.discount}",
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    187, 187, 187, 1),
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          Container(
                                            height: 30,
                                            width: 84,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  242, 242, 242, 1),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(0),
                                            child: Center(
                                              child: Text(
                                                "\$ ${product.product.price.toString()}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: (cart.userCart as Cart).products.length,
                    //     itemBuilder: (context, item) {
                    //       final product = (cart.userCart as Cart).products[item];

                    //       return Padding(
                    //         padding: const EdgeInsets.only(bottom: 20),
                    //         child: Card(
                    //           // color: Colors.white,
                    //           elevation: 1,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: SizedBox(
                    //               height: SizeConfig.screenHeight * 0.18,
                    //               width: MediaQuery.of(context).size.width,
                    //               child: Row(
                    //                 children: [
                    //                   Container(
                    //                     height: SizeConfig.screenHeight * 0.2,
                    //                     width: 123,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(10.0),
                    //                     ),
                    //                     child: ClipRRect(
                    //                       borderRadius: BorderRadius.circular(10.0),
                    //                       child: Image.network(
                    //                         product.product.image,
                    //                         fit: BoxFit.cover,
                    //                         width: MediaQuery.of(context).size.width,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(
                    //                       left: 15,
                    //                     ),
                    //                     child: Column(
                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                    //                       children: [
                    //                         SizedBox(
                    //                           width: SizeConfig.screenWidth * 0.494,
                    //                           child: Row(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.spaceBetween,
                    //                             children: [
                    //                               Padding(
                    //                                 padding: EdgeInsets.only(top: 10),
                    //                                 child: SizedBox(
                    //                                   width:
                    //                                       SizeConfig.screenWidth * 0.3,
                    //                                   child: Text(
                    //                                     product.product.name,
                    //                                     maxLines: 2,
                    //                                     style: const TextStyle(
                    //                                         fontWeight: FontWeight.w600,
                    //                                         fontSize: 14),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               // IconButton(
                    //                               //   padding: EdgeInsets.zero,
                    //                               //   icon: const Icon(
                    //                               //       Icons.delete,
                    //                               //       color: Colors.red),
                    //                               //   onPressed: () async {
                    //                               //     // setState(() {
                    //                               //     //   isRemoveFromCart =
                    //                               //     //       true;
                    //                               //     // });

                    //                               //     // await cartProvider
                    //                               //     //     .removeFromCart(
                    //                               //     //         userProvider
                    //                               //     //             .user!.id,
                    //                               //     //         product.product,
                    //                               //     //         context);
                    //                               //     // setState(() {
                    //                               //     //   isRemoveFromCart =
                    //                               //     //       false;
                    //                               //     // });
                    //                               //   },
                    //                               // ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                         SizedBox(height: 20),
                    //                         if (product.product.discount != 0)
                    //                           Text(
                    //                             "\$ ${product.product.price + product.product.discount}",
                    //                             style: const TextStyle(
                    //                               color:
                    //                                   Color.fromRGBO(187, 187, 187, 1),
                    //                               decoration:
                    //                                   TextDecoration.lineThrough,
                    //                               fontSize: 12,
                    //                               fontWeight: FontWeight.w300,
                    //                             ),
                    //                           ),
                    //                         Container(
                    //                           height: 30,
                    //                           width: 84,
                    //                           decoration: BoxDecoration(
                    //                             color: Color.fromRGBO(242, 242, 242, 1),
                    //                             border: Border.all(
                    //                                 color: Colors.transparent),
                    //                             borderRadius: BorderRadius.circular(5),
                    //                           ),
                    //                           padding: EdgeInsets.all(0),
                    //                           child: Center(
                    //                             child: Text(
                    //                               "\$ ${product.product.price.toString()}",
                    //                               style: TextStyle(
                    //                                   fontSize: 14,
                    //                                   fontWeight: FontWeight.w400),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         //  SizedBox(height: 10),
                    //                         // Row(
                    //                         //   children: [
                    //                         //     Container(
                    //                         //       height: 30,
                    //                         //       width: 84,
                    //                         //       decoration: BoxDecoration(
                    //                         //         color: Color.fromRGBO(
                    //                         //             242, 242, 242, 1),
                    //                         //         border: Border.all(
                    //                         //             color: Colors
                    //                         //                 .transparent),
                    //                         //         borderRadius:
                    //                         //             BorderRadius.circular(
                    //                         //                 5),
                    //                         //       ),
                    //                         //       padding: EdgeInsets.all(0),
                    //                         //       child: Center(
                    //                         //         child: Text(
                    //                         //           "\$ ${product.product.price.toString()}",
                    //                         //           style: TextStyle(
                    //                         //               fontSize: 14,
                    //                         //               fontWeight:
                    //                         //                   FontWeight
                    //                         //                       .w400),
                    //                         //         ),
                    //                         //       ),
                    //                         //     ),
                    //                         //     SizedBox(width: 10),
                    //                         //     Container(
                    //                         //       height: 30,
                    //                         //       width: 84,
                    //                         //       decoration: BoxDecoration(
                    //                         //         color: Color.fromRGBO(
                    //                         //             242, 242, 242, 1),
                    //                         //         border: Border.all(
                    //                         //             color: Colors
                    //                         //                 .transparent),
                    //                         //         borderRadius:
                    //                         //             BorderRadius.circular(
                    //                         //                 5),
                    //                         //       ),
                    //                         //       padding: EdgeInsets.all(0),
                    //                         //       child: Center(
                    //                         //           child: Row(
                    //                         //         mainAxisAlignment:
                    //                         //             MainAxisAlignment
                    //                         //                 .spaceBetween,
                    //                         //         children: [
                    //                         //           SizedBox(width: 10),
                    //                         //           Text(
                    //                         //             "Qty ${product.quantity} ",
                    //                         //             style: const TextStyle(
                    //                         //                 fontSize: 14,
                    //                         //                 fontWeight:
                    //                         //                     FontWeight
                    //                         //                         .w400),
                    //                         //           ),
                    //                         //           Padding(
                    //                         //             padding:
                    //                         //                 const EdgeInsets
                    //                         //                     .only(
                    //                         //                     bottom: 10),
                    //                         //             child: Icon(
                    //                         //               Icons
                    //                         //                   .keyboard_control_key,
                    //                         //               size: 17,
                    //                         //             ),
                    //                         //           )
                    //                         //         ],
                    //                         //       )),
                    //                         //     ),
                    //                         //   ],
                    //                         // ),
                    //                         SizedBox(
                    //                           height: 10,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Order Summary",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bag Value",
                          style: TextStyle(),
                        ),
                        Text(
                          "\$ ${price.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (int.parse(widget.deliverySlot.price) != 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Delivery Charges",
                            style: TextStyle(),
                          ),
                          Text(
                            "\$ ${widget.deliverySlot.price}",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax",
                          style: TextStyle(),
                        ),
                        Text(
                          "\$12",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(.5),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Amount Payable",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "\$ ${totelPrice.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Total Savings",
                    //       style: TextStyle(),
                    //     ),
                    //     SizedBox(
                    //       width: 40,
                    //     ),
                    //     Text(
                    //       "\$12",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w600, color: Colors.red),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(.5),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
