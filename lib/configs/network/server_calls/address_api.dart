import 'package:millyshb/configs/network/api_base.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/user_model.dart';

class AddressAPIs extends ApiBase {
  AddressAPIs() : super();

  Future<ApiResponseWithData<Map<String, dynamic>>> saveAddress(
      Address address) async {
    Map<String, String> data = {
      "receiverName": address.name,
      'userId': address.userId,
      'houseNumber': address.houseNumber,
      'state': address.state,
      'city': address.city,
      'pinCode': address.postalCode,
      'contactNumber': address.mobileNumber,
      'area': address.street,
      'country': address.country
    };

    return await CallHelper().postWithData('api/address/add', data, {});
  }

  Future<ApiResponse> editAddress(
      Address address) async {
    Map<String, String> data = {
      'receiverName': address.name,
      'userId': address.userId,
      'houseNumber': address.houseNumber,
      'state': address.state,
      'city': address.city,
      'pinCode': address.postalCode,
      'contactNumber': address.mobileNumber,
      'area': address.street
    };
    return await CallHelper()
        .put('api/address/update/${address.addressId}', data);
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getAddressList(
      String userId) async {
    return await CallHelper().getWithData('api/address/get/$userId', {});
  }

  Future<ApiResponse> deleteAddress(String userId) async {
    return await CallHelper().delete('api/address/delete/$userId', {});
  }

  Future<ApiResponse> selectAddress(String userId, String addressId) async {
    Map<String, String> data = {"addressId": addressId, "userId": userId};
    return await CallHelper().put('api/address/select', data);
  }
}
