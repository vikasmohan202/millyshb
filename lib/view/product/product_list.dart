import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:millyshb/configs/components/cached_image.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/login_signup/login_screen.dart';
import 'package:millyshb/view/product/product_details_screen.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

// Import your Cart class

class ProductList extends StatefulWidget {
  bool isBackbutton;
  String id;
  ProductList({required this.id, this.isBackbutton = true, super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool isLoading = false;
  bool isAddToCartLoading = false;
  Cart cart = Cart(
      id: "",
      user: "",
      products: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1);

  void _showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: .8, // Set to 1.0 to cover the full screen initially
          minChildSize: .1, // Minimum height when partially dragged
          maxChildSize: 1, // Maximum height when fully dragged
          expand: true,
          builder: (context, scrollController) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: const LoginScreen(
                  isbottomSheet: true,
                ));
          },
        );
      },
    ).whenComplete(() {
      // Call setState to update the UI after the bottom sheet is closed
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    // Add a listener to the search controller
    _getProductList(
      widget.id,
    );
    _searchController.addListener(() {
      _filterProducts();
    });
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    setState(() {
      _filteredProducts = productProvider.products.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _getProductList(String id) async {
    setState(() {
      isLoading = true;
    });

    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.getListOfProduct(id, context);
    setState(() {
      isLoading = false;
    });
  }

  void _onSearch(BuildContext context) async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      await productProvider.searchProduct(_searchController.text, context);
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;
    Provider.of<ProductProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return isLoading
        ? const loadingIndicator()
        : Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: widget.isBackbutton,
                  backgroundColor: Colors.white,
                  forceMaterialTransparency: true,
                  centerTitle: true,
                  title:
                      const Image(image: AssetImage("assets/images/logo.png")),
                  actions: [
                    badges.Badge(
                      ignorePointer: true,
                      badgeContent: Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return Center(
                            child: Text(
                              (cart.userCart as Cart)
                                  .products
                                  .length
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      showBadge: (cart.userCart as Cart).products.isNotEmpty,
                      position: badges.BadgePosition.topEnd(top: 0, end: 3),
                      child: IconButton(
                        onPressed: () {
                          if (isLogin) {
                            Navigator.of(context)
                                .pushNamed(RoutesName.shoppingBag);
                          } else {
                            _showLoginBottomSheet(context);
                          }
                        },
                        icon: const Icon(Icons.shopping_bag_outlined),
                      ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      BrandedTextField(
                        isFilled: false,
                        height: 40,
                        sufix: const Icon(
                          Icons.mic_outlined,
                          size: 16,
                        ),
                        prefix: const Icon(
                          Icons.search,
                          size: 16,
                        ),
                        controller: _searchController,
                        labelText: "Search any product",
                        onChanged: (p0) {
                          _onSearch(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Consumer<ProductProvider>(
                          builder: (context, productProvider, child) {
                            if (productProvider.searchedProduct.isEmpty) {
                              return Center(
                                child: Text(
                                  'No products available',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: productProvider.searchedProduct.length,
                              itemBuilder: (context, index) {
                                Product product =
                                    productProvider.searchedProduct[index];

                                bool inCart = false;
                                for (var cartProduct
                                    in (cart.userCart as Cart).products) {
                                  if (cartProduct.product.id == product.id) {
                                    inCart = true;
                                    break;
                                  }
                                }

                                bool isFav = false;
                                for (var favProduct
                                    in productProvider.favProduct) {
                                  if ((favProduct as Product).id ==
                                      product.id) {
                                    isFav = true;
                                    break;
                                  }
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ProductDetailsScreen(
                                                product: product);
                                          },
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: SizeConfig.screenHeight * .18,
                                          child: Row(
                                            children: [
                                              Container(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        .171,
                                                width: SizeConfig.screenWidth *
                                                    .32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: CustomCachedImage(
                                                  imageUrl: product.image,
                                                  borderRadius: 10.0,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.cover,
                                                  placeholder: Container(
                                                    color: Colors.grey[200],
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: Colors.grey,
                                                      size: 50,
                                                    ),
                                                  ),
                                                  errorWidget: Container(
                                                    color: Colors.grey[200],
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: Colors.red,
                                                      size: 50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.39,
                                                          child: Text(
                                                            product.name,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                        if (isLogin)
                                                          IconButton(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            onPressed:
                                                                () async {
                                                              setState(() {
                                                                isAddToCartLoading =
                                                                    true;
                                                              });
                                                              if (isFav) {
                                                                await productProvider
                                                                    .removeFavProduct(
                                                                  product,
                                                                  userProvider
                                                                      .user!.id,
                                                                  context,
                                                                );
                                                              } else {
                                                                await productProvider
                                                                    .addFavProduct(
                                                                  product,
                                                                  userProvider
                                                                      .user!.id,
                                                                  context,
                                                                );
                                                              }
                                                              setState(() {
                                                                isAddToCartLoading =
                                                                    false;
                                                              });
                                                            },
                                                            icon: isFav
                                                                ? const Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                  ),
                                                          ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      "\$${product.price.toString()}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    SizedBox(
                                                      height: 29,
                                                      width: 84,
                                                      child: OutlinedButton(
                                                        onPressed: () async {
                                                          if (inCart) {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                              RoutesName
                                                                  .shoppingBag,
                                                            );
                                                          } else {
                                                            setState(() {
                                                              isAddToCartLoading =
                                                                  true;
                                                            });
                                                            if (isLogin) {
                                                              await cart
                                                                  .addTOCart(
                                                                product,
                                                                userProvider
                                                                    .user!.id,
                                                                context,
                                                              );
                                                            } else {
                                                              await cart
                                                                  .addTOCart(
                                                                product,
                                                                '',
                                                                context,
                                                              );
                                                            }
                                                            setState(() {
                                                              isAddToCartLoading =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 0),
                                                          backgroundColor:
                                                              Colors.white,
                                                          side:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    202,
                                                                    202,
                                                                    202,
                                                                    1),
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: !inCart
                                                              ? const Text(
                                                                  "Add To Cart",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                )
                                                              : const Text(
                                                                  "Go To Cart",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isAddToCartLoading || _isSearching)
                loadingIndicator(
                  isTransParent: true,
                )
            ],
          );
  }
}
