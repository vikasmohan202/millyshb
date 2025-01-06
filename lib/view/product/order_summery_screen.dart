import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/models/coupon_model.dart';
import 'package:millyshb/models/delivery_slot_model.dart';
import 'package:millyshb/view/payment/payment_screen.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class OrderSummery extends StatefulWidget {
  final DeliverySlot deliverySlot;
  const OrderSummery({required this.deliverySlot, super.key});

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
  bool isLoading = false;
  double price = 0.0;
  double totalPrice = 0.0;
  bool showAllCoupons = false;
  final TextEditingController _codeController = TextEditingController();
  Coupon? appliedCoupon; // State variable to keep track of applied coupon

  // addPayment() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final cart = Provider.of<CartProvider>(context, listen: false);

  //   for (CartItem product in (cart.userCart as Cart).products) {
  //     price = price + (product.product.price - product.product.discount);
  //   }
  //   totalPrice = price + int.parse(widget.deliverySlot.price) + 12;

  //   // Apply coupon discount if a coupon is applied
  //   if (appliedCoupon != null) {
  //     totalPrice -= appliedCoupon!.discountValue;
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  addPayment() {
    setState(() {
      isLoading = true;
    });

    final cart = Provider.of<CartProvider>(context, listen: false);
    price = 0;

    // Calculate the total price of products in the cart, including discounts
    for (CartItem product in (cart.userCart as Cart).products) {
      price += (product.product.price * product.quantity -
          product.product.discount * product.quantity);
    }

    // Parse delivery slot price safely and add it to the total price
    int deliverySlotPrice = 0;
    if (widget.deliverySlot.price != "null" &&
        widget.deliverySlot.price.isNotEmpty) {
      deliverySlotPrice = int.tryParse(widget.deliverySlot.price) ?? 0;
    }

    // Add delivery slot price and fixed delivery fee
    totalPrice = price + deliverySlotPrice + 12;

    // Apply coupon discount if a coupon is applied
    if (appliedCoupon != null) {
      totalPrice -= appliedCoupon!.discountValue;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    addPayment();
    super.initState();
  }

  void applyCoupon(Coupon coupon) {
    setState(() {
      appliedCoupon = coupon;
      totalPrice -= coupon.discountValue;
    });
  }

  void removeCoupon() {
    setState(() {
      totalPrice += appliedCoupon!.discountValue;
      appliedCoupon = null;
    });
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
                "Summary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: BrandedPrimaryButton(
                    isEnabled: true,
                    name: "Proceed to Payment",
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PaymentScreen(
                          deliverySlot: widget.deliverySlot,
                          price: totalPrice,
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
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: cart.lstCoupon
                                    .take(showAllCoupons
                                        ? cart.lstCoupon.length
                                        : 2)
                                    .map((coupon) {
                                  bool isApplied =
                                      appliedCoupon?.id == coupon.id;
                                  return Card(
                                    elevation: 1,
                                    child: ListTile(
                                      trailing: TextButton(
                                        onPressed: () {
                                          if (isApplied) {
                                            removeCoupon();
                                          } else {
                                            applyCoupon(coupon);
                                          }
                                        },
                                        child: Text(
                                            isApplied ? "Remove" : "Apply"),
                                      ),
                                      title: Text(coupon.code),
                                      subtitle:
                                          Text(coupon.discountValue.toString()),
                                    ),
                                  );
                                }).toList(),
                              ),
                              if (cart.lstCoupon.length > 2)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        showAllCoupons = !showAllCoupons;
                                      });
                                    },
                                    child: Text(
                                      showAllCoupons
                                          ? "View Less"
                                          : "View More",
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
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
                                                SizeConfig.screenWidth * 0.45,
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
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          if (product.product.discount != 0)
                                            Text(
                                              "\$ ${product.product.price}",
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    187, 187, 187, 1),
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      242, 242, 242, 1),
                                                  border: Border.all(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                padding: const EdgeInsets.all(0),
                                                child: Center(
                                                  child: Text(
                                                    "\$ ${(product.product.price * product.quantity).toString()}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                              ),
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      242, 242, 242, 1),
                                                  border: Border.all(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                padding: const EdgeInsets.all(0),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Space between the icon and text
                                                      Text(
                                                        " ${(product.quantity).toString()}",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Icon(
                                                        Icons
                                                            .production_quantity_limits, // Icon representing quantity
                                                        size: 18,
                                                        color: Colors
                                                            .grey, // You can customize the color
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
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
                          "\$ ${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                  ],
                ),
              ),
            ),
          );
  }
}
