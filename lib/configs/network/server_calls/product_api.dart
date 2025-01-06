import 'package:millyshb/configs/network/api_base.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/user_model.dart';

class ProductAPIs extends ApiBase {
  ProductAPIs() : super();
//
  Future<ApiResponseWithData<Map<String, dynamic>>> getCategories() async {
    return await CallHelper().getWithData('api/category/get', {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getSubCategoriesById(
      String id) async {
    return await CallHelper().getWithData('api/category/get/$id', {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getFavoriteProduct(
      String id) async {
    return await CallHelper().getWithData('api/favorite/get/$id', {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getDiscountedProduct(
      String id) async {
    return await CallHelper().getWithData('api/product/getdiscount/$id', {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> searchProduct(
      String name) async {
    Map<String, dynamic> data = {'name': name};

    return await CallHelper().postWithData('api/product/search', data, {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getOrders(String id) async {
    return await CallHelper().getWithData('api/product/order-history/$id', {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getProductById(
      String id) async {
    return await CallHelper().getWithData('api/product/subcategory/$id', {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getRecommendedProductById(
      String id) async {
    return await CallHelper().getWithData('api/product/recommended/$id', {});
  }
  //api/product/recommended/66a338b8dc8ca180402cc419

  Future<ApiResponseWithData<Map<String, dynamic>>> addFavorite(
      String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
    };

    return await CallHelper().postWithData('api/favorite/add', data, {});
  }

  Future<ApiResponse> removeFavorite(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
    };

    return await CallHelper().delete(
      'api/favorite/delete',
      data,
    );
  }

  Future<ApiResponse> deleteAddress(String userId) async {
    return await CallHelper().delete('api/address/delete/$userId', {});
  }
}
