import 'package:millyshb/configs/network/api_base.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/user_model.dart';

class OrderApi extends ApiBase {
  OrderApi() : super();

  Future<ApiResponseWithData<Map<String, dynamic>>> createOrder(
      String userId, String slotId) async {
    Map<String, String> data = {'userId': userId, 'deliverySlotId': slotId};

    return await CallHelper().postWithData('api/product/order', data, {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> cancelOrder(
      String orderId) async {
    Map<String, String> data = {
      'userId': orderId,
    };

    return await CallHelper()
        .postWithData('api/product/cancel/$orderId', data, {});
  }
  

  Future<ApiResponseWithData<Map<String, dynamic>>> getAllOrders(
      String userId) async {
    return await CallHelper().getWithData('api/cart/get/$userId', {});
  }
  // 
  //  Future<ApiResponseWithData<List<Category>>> getServices(
  //     {bool foreceRefresh = false}) async {
  //   // bool isfound = await PDFApi.checkIfFileExists(salonServicesLocalFilePath);
  //   // print(isfound);
  //   if (foreceRefresh ||
  //       !await PDFApi.checkIfFileExists(salonServicesLocalFilePath)) {
  //     return await _getServicesFromServer();
  //   }

  //   var json =
  //       await PDFApi.readFileFromLocalDirectory(salonServicesLocalFilePath);

  //   List<Category> categories = await _getServicesFromJson(jsonDecode(json));

  //   return ApiResponseWithData<List<Category>>(categories, true, message: "");
  // }


  Future<ApiResponseWithData<Map<String, dynamic>>> getCoupon(
      ) async {
    return await CallHelper().getWithData('api/voucher/get', {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getSlot(
      String deliveryType) async {
    // deliveryType
    Map<String, String> data = {"deliveryType": deliveryType};

    return await CallHelper().getWithData('api/deliveryslot/get', data);
  }
}
