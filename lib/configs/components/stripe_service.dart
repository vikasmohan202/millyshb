import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/network/call_helper.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<ApiResponseWithData<String>> makePayment(
    double price,
  ) async {
    try {
      // Create payment intent and get full response data
      Map<String, dynamic>? paymentIntentResponse =
          await _createPaymentIntent(price, "usd");

      if (paymentIntentResponse == null) {
        return ApiResponseWithData<String>("", false,
            message: "Payment intent creation failed");
      }

      // Extract client secret from the response
      String? paymentIntentClientSecret =
          paymentIntentResponse["client_secret"];
      String paymentId = paymentIntentResponse["id"];

      if (paymentIntentClientSecret == null) {
        return ApiResponseWithData<String>("", false,
            message: "Client secret not found");
      }

      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: "SE",
            testEnv: true,
          ),
          merchantDisplayName: "Millyshb",
        ),
      )
      ;
      

      // Process payment and return response
      bool paymentSuccess = await _paymentProcess(paymentIntentClientSecret);
      if (paymentSuccess) {
        return ApiResponseWithData<String>(paymentId, true,
            message: "Payment successful");
      } else {
        return ApiResponseWithData<String>("", false,
            message: "Payment process failed");
      }
    } catch (e) {
      return ApiResponseWithData<String>("", false,
          message: "Error in makePayment: $e");
    }
  }

  Future<bool> _paymentProcess(String clientSecret) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Payment successful");
      return true;
    } catch (e) {
      print("Error in _paymentProcess: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent(
      double amount, String currency) async {
    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        "amount": (10 * 100), // Stripe expects smallest currency unit
        "currency": currency,
      };

      Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Content-Type": 'application/x-www-form-urlencoded',
          "Authorization": "Bearer $secretKey",
        },
      );

      var response = await dio
          .post(
            "https://api.stripe.com/v1/payment_intents",
            data: data,
            options: options,
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("Payment Intent Created: ${response.data}");
        return response.data; // Return full response data
      } else {
        print("Failed to create payment intent: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error in _createPaymentIntent: $e");
      return null;
    }
  }

  Future<ApiResponseWithData> generateTokenFromCardField() async {
    try {
      // Collect card details using the CardField widget
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      print("Token Created: ${paymentMethod.id}");
      return ApiResponseWithData(paymentMethod.id, true); // Return the token ID
    } catch (e) {
      print("Error in generateTokenFromCardField: $e");
      return ApiResponseWithData(e, false); // Return null if an error occurs
    }
  }

  Future<void> createRefund(String paymentIntentId) async {
    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {"payment_intent": paymentIntentId};

      Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Content-Type": 'application/x-www-form-urlencoded',
          "Authorization": "Bearer $secretKey",
        },
      );

      var response = await dio.post(
        "https://api.stripe.com/v1/refunds",
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        print("Refund Successful: ${response.data}");
      } else {
        print("Failed to create refund: ${response.statusCode}");
        print("Response Data: ${response.data}");
      }
    } catch (e) {
      print("Error in createRefund: $e");
    }
  }
}
