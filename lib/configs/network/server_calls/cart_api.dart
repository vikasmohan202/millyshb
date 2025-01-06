import 'package:millyshb/configs/network/api_base.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/user_model.dart';

class CartAPIs extends ApiBase {
  CartAPIs() : super();

  Future<ApiResponseWithData<Map<String, dynamic>>> addProductToCart(
      String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
      'quantity': '1'
    };

    return await CallHelper().postWithData('api/cart/add', data, {});
  }

  Future<ApiResponse> removeProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
    };

    return await CallHelper().delete(
      'api/cart/delete/$productId',
      data,
    );
  }

  Future<ApiResponse> increaseProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
      'operation': "increase"
    };

    return await CallHelper().put(
      'api/cart/change',
      data,
    );
  }

  Future<ApiResponse> decreaseProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
      'operation': "decrease"
    };

    return await CallHelper().put(
      'api/cart/change',
      data,
    );
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getCart(
      String userId) async {
    Map<String, String> data = {
      'userId': userId,
    };
    return await CallHelper().getWithData('api/cart/get/$userId', data);
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getSlot(
      String deliveryType) async {
    Map<String, String> data = {"deliveryType": deliveryType};

    return await CallHelper().getWithData('api/deliveryslot/get', data);
  }

// {
//     "userId": "66f10d4271e24863544b777c",
//     "deliverySlotId":"66b42e7f6657543e722e7272",
//     "addressId": "66f299b02a7c23c1f0cc5ac5",
//     "paymentMethod": "paypal",
//     "paymentId": "PAYID-M4LYRKI7LJ82889W4312874R",
//     "payerId": "L4CRP7AJ8BRQJ"
// }
  // New method to create an order
  Future<ApiResponseWithData<Map<String, dynamic>>> createOrder(
      {required String userId,
      required String deliverySlotId,
      required String addressId,
      required String paymentMethod,
      required String paymentId,
      required String playerId}) async {
    Map<String, String> data = {
      'userId': userId,
      'deliverySlotId': deliverySlotId,
      'addressId': addressId,
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
      "payerId": playerId
    };

    return await CallHelper().postWithData(
      'api/product/order',
      data,
      {},
    );
  }
}
