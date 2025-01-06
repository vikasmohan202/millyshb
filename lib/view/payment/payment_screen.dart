import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:provider/provider.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/error_success_dialogue.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/stripe_service.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/delivery_slot_model.dart';
import 'package:millyshb/view/payment/payment_success_screen.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';

class PaymentScreen extends StatefulWidget {
  var price;
  DeliverySlot deliverySlot;
  PaymentScreen({required this.deliverySlot, required this.price, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = false;
  String selectedPaymentMethod = '';
  Address selectedAddress = Address(
    houseNumber: "12",
    userId: "",
    name: "Home",
    mobileNumber: "",
    street: "",
    city: "",
    state: "state",
    postalCode: "",
    country: "",
    addressType: AddressType.HOME,
  );

  getAddress() {
    String addressId = SharedPrefUtil.getValue(selectedAddressId, "") as String;

    if (addressId.isNotEmpty) {
      // Fetch the list of addresses from the provider
      List<dynamic> addresses =
          Provider.of<AddressProvider>(context, listen: false).address;

      // Find the address where the id matches the given addressId
      selectedAddress = addresses.firstWhere(
        (item) => item.addressId == addressId,
        orElse: () => Address(
          houseNumber: "12",
          userId: "",
          name: "Home",
          mobileNumber: "",
          street: "",
          city: "",
          state: "state",
          postalCode: "",
          country: "",
          addressType: AddressType.HOME,
        ),
      );
    } else {
      // If no addressId is available, use default address
      selectedAddress = Address(
        houseNumber: "12",
        userId: "",
        name: "Home",
        mobileNumber: "",
        street: "",
        city: "",
        state: "state",
        postalCode: "",
        country: "",
        addressType: AddressType.HOME,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                "Checkout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                      Text(
                        "\$ ${(widget.price - int.parse(widget.deliverySlot.price)).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                      Text(
                        "\$ ${widget.deliverySlot.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$ ${widget.price}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
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
                  _buildPaymentOption(
                      "Visa", "assets/images/visa.png", "******2109"),
                  const SizedBox(height: 20),
                  _buildPaymentOption(
                      "PayPal", "assets/images/paypal.png", "******2109"),
                  const SizedBox(height: 20),
                  _buildPaymentOption(
                      "Stripe", "assets/images/maestro.png", "******2109"),
                  const SizedBox(height: 20),
                  _buildPaymentOption(
                      "PayPal (Alt)", "assets/images/paypal.png", "******2109"),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: BrandedPrimaryButton(
                      isEnabled: selectedPaymentMethod.isNotEmpty,
                      name: "Continue",
                      onPressed: () async {
                        if (selectedPaymentMethod == "Stripe") {
                          setState(() {
                            isLoading = true;
                          });
                          ApiResponseWithData responseWithData =
                              await StripeService.instance
                                  .makePayment(widget.price);
                          if (responseWithData.success) {
                            await _handleOrderCreation(responseWithData.data);
                          } else {
                            _showErrorDialog(responseWithData.message);
                          }
                        } else if (selectedPaymentMethod == "PayPal") {
                          _processPaypalPayment();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildPaymentOption(
      String paymentMethod, String assetPath, String cardNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethod;
        });
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPaymentMethod == paymentMethod
                ? Colors.blue
                : Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.withOpacity(.15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              width: 60,
              child: Image.asset(assetPath),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(cardNumber),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleOrderCreation(String paymentId) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String addressId = SharedPrefUtil.getValue(selectedAddressId, "") as String;
    await cartProvider.createOrder(
      userId: userProvider.user!.id,
      deliverySlotId: widget.deliverySlot.id,
      addressId: addressId,
      paymentMethod: selectedPaymentMethod.toLowerCase(),
      paymentId: paymentId,
      playerId: '',
      context: context,
    );
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PaymentSuccessScreen();
    }));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessAndErrorDialougeBox(
          subTitle: "Error",
          isSuccess: false,
          title: message,
          action: () {},
        );
      },
    );
  }

  void _processPaypalPayment() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckout(
        sandboxMode: true,
        clientId: PAYPAL_CLIENT_ID,
        secretKey: PAYPAL_CLIENT_SECRET,
        returnURL: "com.millysshop.app",
        cancelURL: "https://aayaninfotech.com/",
        transactions: [
          {
            "amount": {
              "total": widget.price.toString(),
              "currency": "USD",
              "details": {
                "subtotal": widget.price.toString(),
                "shipping": '0',
                "shipping_discount": 0,
              },
            },
            "description": "Payment transaction description.",
            "item_list": {
              "items": [
                {
                  "name": "Product",
                  "quantity": 1,
                  "price": widget.price.toString(),
                  "currency": "USD",
                },
              ],
              "shipping_address": {
                "recipient_name": selectedAddress.name,
                "line1": selectedAddress.street,
                "city": selectedAddress.city,
                "country_code": "SE",
                "postal_code": selectedAddress.postalCode,
                "phone": selectedAddress.mobileNumber,
                "state": selectedAddress.state,
              },
            },
          }
        ],
        note: "PAYMENT_NOTE",
        onSuccess: (Map params) async {
          print(params);
          var data = params["data"];
          var player = data["payer"];
          var playerInfo = player["payer_info"];
          final cartProvider =
              Provider.of<CartProvider>(context, listen: false);
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          String addressId =
              SharedPrefUtil.getValue(selectedAddressId, "") as String;
          await cartProvider.createOrder(
            userId: userProvider.user!.id,
            deliverySlotId: widget.deliverySlot.id,
            addressId: addressId,
            paymentMethod: selectedPaymentMethod.toLowerCase(),
            paymentId: data["id"],
            playerId: playerInfo["payer_id"],
            context: context,
          );
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ));
  }
}
