import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/network/call_helper.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> generateTokenByCard(
    String cardNo,
    String cvv,
    String expiryDate,
    String cardHolderName,
    String totalAmount,
    String bookingId,
  ) async {
    var mDate = expiryDate.split("/");

    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
      number: cardNo.removeAllWhitespace(),
      cvc: cvv,
      expirationMonth: int.tryParse(mDate.first),
      expirationYear: int.tryParse(mDate[1]),
    ));

    var cardParams = CardTokenParams(
      type: TokenType.Card,
      name: cardHolderName,
      address: Address(
        city: '', //selectedAddress.value?.city ?? "",
        country: '', //selectedAddress.value?.country ?? "",
        line1: '', //selectedAddress.value?.street ?? "",
        line2: '',
        state: "",
        postalCode: "",
      ),
    );

    var token = await Stripe.instance.createToken(
      CreateTokenParams.card(params: cardParams),
    );

    // Proceed with payment using token.id
    print('Token generated: ${token.id}');
  }

   showCardPaymentSheet({
    required BuildContext context,
    // required String cardHolderName,
    // required String totalAmount,
    // required String bookingId,
  }) {
    final TextEditingController cardNoController = TextEditingController();
    final TextEditingController expiryDateController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (builder) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight * 0.9,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: cardNoController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Card Number",
                            ),
                            validator: (v) {
                              if (v == null || v.length != 16) {
                                return "Invalid card number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  controller: expiryDateController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Expiry Date (MM/YY)",
                                  ),
                                  validator: (v) {
                                    if (v == null || v.length != 5) {
                                      return "Invalid expiry date";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  controller: cvvController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "CVV",
                                  ),
                                  validator: (v) {
                                    if (v == null || v.length != 3) {
                                      return "Invalid CVV";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onSurface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.6,
                                  50,
                                ),
                              ),
                              onPressed: () async {
                                // Validate input fields
                                if (cardNoController.text.isEmpty ||
                                    expiryDateController.text.isEmpty ||
                                    cvvController.text.isEmpty) {
                                  print('Please fill all fields');
                                  return;
                                }

                                // Generate payment token using card details
                                await StripeService.instance.generateTokenByCard(
                                  cardNoController.text,
                                  cvvController.text,
                                  expiryDateController.text,
                                  "cardHolderName",
                                  "totalAmount",
                                  "bookingId",
                                );
                              },
                              child: const Text(
                                "Proceed to Pay",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

extension StringExtensions on String {
  String removeAllWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }
}
