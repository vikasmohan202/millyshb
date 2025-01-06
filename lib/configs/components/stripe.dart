//  Future<void> generateTokenByCard(String cardNo, String cvv, String expiryDate,
//       String cardHolderName, String totalAmount, String bookingId) async {
//     var mDate = expiryDate.split("/");
//     await stripe.Stripe.instance.dangerouslyUpdateCardDetails(stripe.CardDetails(
//       number: cardNo.removeAllWhitespace,
//       cvc: cvv,
//       expirationMonth: int.tryParse(mDate.first),
//       expirationYear: int.tryParse(mDate[1]),
//     ));

//     var cardParams = stripe.CardTokenParams(
//       type: stripe.TokenType.Card,
//       name: cardHolderName,
//       address: stripe.Address(
//         city: selectedAddress.value?.city ?? "",
//         country: selectedAddress.value?.country ?? "",
//         line1: selectedAddress.value?.street ?? "",
//         line2: '',
//         state: selectedAddress.value?.state ?? "",
//         postalCode: selectedAddress.value?.zipCode ?? "",
//       ),
//     );

//     try {
//       var token = await stripe.Stripe.instance.createToken(
//         stripe.CreateTokenParams.card(params: cardParams),
//       );

//       var res = await DashRepo().payment(
//           totalAmount, token.id, bookingId, confirmationIdController.text);
//       res.when(success: (mData) {
//         LoaderView.hideLoading();
//         if (mData.status == 200) {
//           LoaderView.showAlertView(
//               title: "Success",
//               description: mData.msg.toString(),
//               showSecondary: false,
//               onPressed: () {
//                 Get.back();
//                 // Get.back();
//                 Get.offNamedUntil(
//                     Routes.feedback, ModalRoute.withName(Routes.home),
//                     arguments: {
//                       "bookingId": bookingId,
//                       "confirmationNo": confirmationIdController.text
//                     });
//               });
//         }
//       }, error: (error) {
//         LoaderView.hideLoading();
//         LoaderView.showErrorDialog(description: error.message);
//       });
//     } catch (e) {
//       LoaderView.hideLoading();
//       if (e is stripe.StripeException) {
//         LoaderView.showErrorDialog(description: e.error.localizedMessage);
//       }
//     }
//   }