import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/error_success_dialogue.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/address_api.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AddressProvider with ChangeNotifier {
  // List to hold products
  List<dynamic> _address = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Getter for the product list
  List<dynamic> get address => _address;

  getAddressList(String userId, BuildContext context) async {
    ApiResponseWithData response = await AddressAPIs().getAddressList(userId);
    if (response.success) {
      _address = (response.data["data"])
          .map((addressJson) => Address.fromJson(addressJson))
          .toList();
    } else {}
  }

  saveAddress(Address address, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    ApiResponseWithData response = await AddressAPIs().saveAddress(address);
    if (response.success) {
      _address.add(address);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessAndErrorDialougeBox(
              subTitle: "Success",
              isSuccess: true,
              title: 'Address Added successfully',
              action: () {},
            );
          }).then((value) async {
        Navigator.of(context).pop();
      });
    } else {}
    _setLoading(false);
  }

  editAddress(Address address, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ApiResponse response = await AddressAPIs().editAddress(address);
    if (response.success) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessAndErrorDialougeBox(
              subTitle: "Success",
              isSuccess: true,
              title: 'Address Edited successfully',
              action: () {},
            );
          }).then((value) async {
        Navigator.of(context).pop();
      });
      await getAddressList(userProvider.user!.id, context);
      Navigator.of(context).pop();
    } else {}
  }

  deleteAddress(Address address, BuildContext context) async {
    ApiResponse response =
        await AddressAPIs().deleteAddress(address.addressId);
    if (response.success) {
      _address.remove(address);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessAndErrorDialougeBox(
              subTitle: "Success",
              isSuccess: true,
              title: 'Address deleted successfully',
              action: () {},
            );
          }).then((value) async {});
    } else {}
    notifyListeners();
  }

  selectAddress(String addressId, String userId, BuildContext context) async {
    SharedPrefUtil.setValue(selectedAddressId, addressId);
    ApiResponse response = await AddressAPIs().selectAddress(userId, addressId);
    if (response.success) {
      SharedPrefUtil.setValue(selectedAddressId, addressId);
    } else {}
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
