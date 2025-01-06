import 'package:flutter/material.dart';
import 'package:millyshb/models/user_model.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UserContextData {
  static UserModel? _user;

  static UserModel? get user => _user;

  static setCurrentUserAndFetchUserData(BuildContext context) async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    _user = user;
    List<Future> lstFutures = <Future>[];

    lstFutures.add(productProvider.getCategoryList(context));
    lstFutures
        .add(addressProvider.getAddressList(userProvider.user!.id, context));
    lstFutures.add(cartProvider.getCart(userProvider.user!.id, context));
    lstFutures
        .add(productProvider.getFavProduct(userProvider.user!.id, context));
    // lstFutures.add(cartProvider.getCoupon(context));
    // lstFutures
    //     .add(productProvider.getOrderList(userProvider.user!.id, context));

    await Future.wait(lstFutures);
  }
}
