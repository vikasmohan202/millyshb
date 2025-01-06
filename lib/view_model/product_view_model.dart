import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/pdf_api.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/product_api.dart';
import 'package:millyshb/models/category_model.dart';
import 'package:millyshb/models/order_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/models/sub_category_model.dart';

class ProductProvider with ChangeNotifier {
  List<dynamic> _products = [];
  List<dynamic> _searchedProduct = [];
  List<dynamic> _favProducts = [];
  List<dynamic> _discountProduct = [];
  List<dynamic> get discountProduct => _discountProduct;
  List<dynamic> get searchedProduct => _searchedProduct;
  List<dynamic> _recommendedProducts = [];
  List<dynamic> _category = [];
  List<dynamic> _subCategory = [];
  List<Order> _orders = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _selectedCategoryId = '';
  String _selectedSubCategoryId = '';
  String get selectedCategoryId => _selectedCategoryId;
  String get selectedSubCategoryId => _selectedSubCategoryId;
  List<dynamic> get products => _products;
  List<dynamic> get recommendedProducts => _recommendedProducts;

  List<dynamic> get favProduct => _favProducts;
  List<dynamic> get category => _category;
  List<dynamic> get subCategory => _subCategory;
  List<Order> get orders => _orders;

  set selectedCategoryId(String selectedCategoryId) {
    _selectedCategoryId = selectedCategoryId;
    notifyListeners();
  }

  set selectedSubCategoryId(String selectedSubCategoryId) {
    _selectedSubCategoryId = selectedSubCategoryId;
    notifyListeners();
  }

  Future<void> getCategoryList(BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response = await ProductAPIs().getCategories();
      if (response.success) {
        _category = (response.data["data"] as List)
            .map((item) => ProductCategory.fromJson(item))
            .toList();
      } else {
        // _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to load categories');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getSubCategoryList(String id, BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response =
          await ProductAPIs().getSubCategoriesById(id);
      if (response.success) {
        _subCategory = (response.data["subcategories"] as List)
            .map((item) => SubCategory.fromJson(item))
            .toList();
      } else {
        _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to load subcategories');
    } finally {
      _setLoading(false);
    }
  }

  getOrderList(String userId, BuildContext context,
      {bool isForceRefresh = false}) async {
    bool isfound = await PDFApi.checkIfFileExists(userOrderListFilePath);
    if (isfound && !isForceRefresh) {
      var json = await PDFApi.readFileFromLocalDirectory(userOrderListFilePath);
      var data = jsonDecode(json);
      _orders =
          (data["data"] as List).map((item) => Order.fromJson(item)).toList();
    } else {
      ApiResponseWithData response = await ProductAPIs().getOrders(userId);

      if (response.success) {
        _orders = (response.data["data"] as List)
            .map((item) => Order.fromJson(item))
            .toList();
        PDFApi.saveFileToLocalDirectory(
            json.encode(response.data), userOrderListFilePath);
      } else {}
    }
  }

  Future<void> getFavProduct(String id, BuildContext context,
      {bool isForceRefresh = false}) async {
    try {
      bool isfound = await PDFApi.checkIfFileExists(userFavProduct);

      ApiResponseWithData response = await ProductAPIs().getFavoriteProduct(id);
      if (response.success) {
        _favProducts = (response.data['data']["products"] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to load subcategories');
    } finally {}
    notifyListeners();
  }

  Future<void> getRecomProduct(String id, BuildContext context) async {
    try {
      ApiResponseWithData response =
          await ProductAPIs().getRecommendedProductById(id);
      if (response.success) {
        _recommendedProducts = (response.data['data'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        // _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      // _showErrorSnackbar(context, 'Failed to load subcategories');
    } finally {}
    notifyListeners();
  }

  Future<void> getProductList(String id, BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response = await ProductAPIs().getProductById(id);
      if (response.success) {
        _products = response.data["status"] == 404
            ? []
            : (response.data["data"] as List)
                .map((item) => Product.fromJson(item))
                .toList();
      } else {
        _products = [];
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> searchProduct(String name, BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response = await ProductAPIs().searchProduct(name);
      if (response.success) {
        _searchedProduct = response.data["status"] == 404
            ? []
            : (response.data["data"] as List)
                .map((item) => Product.fromJson(item))
                .toList();
      } else {
        _products = [];
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> getDiscountedProductList(String id, BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response =
          await ProductAPIs().getDiscountedProduct(id);
      if (response.success) {
        _discountProduct = response.data["status"] == 404
            ? []
            : (response.data["data"] as List)
                .map((item) => Product.fromJson(item))
                .toList();
        print(_discountProduct);
      } else {
        _discountProduct = [];
      }
    } finally {
      notifyListeners();
    }
  }

  Future<List<Product>> getListOfProduct(
      String id, BuildContext context) async {
    _setLoading(true);
    List<Product> productList = []; // Initialize an empty product list

    try {
      ApiResponseWithData response = await ProductAPIs().getProductById(id);
      if (response.success) {
        if (response.data["status"] != 404) {
          productList = (response.data["data"] as List)
              .map((item) => Product.fromJson(item))
              .toList();
        }
      } else {
        _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to load products');
    } finally {
      _setLoading(false); // Stop loading
    }

    return productList; // Return the product list
  }

  addFavProduct(Product product, String userId, BuildContext context) async {
    ApiResponseWithData response =
        await ProductAPIs().addFavorite(product.id, userId);
    if (response.success) {
      _favProducts.add(product);
      getFavProduct(userId, context);
    } else {}
    notifyListeners();
  }

  removeFavProduct(Product product, String userId, BuildContext context) async {
    ApiResponse response =
        await ProductAPIs().removeFavorite(product.id, userId);
    if (response.success) {
      await getFavProduct(userId, context);
    } else {}
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    //notifyListeners();
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     backgroundColor: Colors.red,
    //   ),
    // );
  }
}
