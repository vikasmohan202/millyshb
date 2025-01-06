import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/models/category_model.dart';
import 'package:millyshb/view/splash/store_splash.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/select_store_view_model.dart';
import 'package:provider/provider.dart';

class StoreCard extends StatefulWidget {
  final bool isFood;
  ProductCategory category;

  StoreCard({
    this.isFood = false,
    required this.category,
    super.key,
  });

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white
          .withOpacity(.6), //const Color.fromARGB(255, 218, 218, 248),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          //  height: SizeConfig.blockSizeVertical * 17,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 33,
                  height: MediaQuery.of(context).size.height * .15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        Image(image: NetworkImage(widget.category.pictureUrl)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Text(
                          widget.category.title
                              .trim(), // This will trim leading and trailing spaces
                          maxLines: 2,
                          textAlign: TextAlign.left, // Align text to the left
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 37,
                        height: SizeConfig.blockSizeVertical * 4.6,
                        child: BrandedPrimaryButton(
                          isEnabled: true,
                          name: "Shopping",
                          onPressed: () {
                            Provider.of<ProductProvider>(context, listen: false)
                                .selectedCategoryId = widget.category.id;

                            if (widget.isFood) {
                              Provider.of<SelectStoreProvider>(context,
                                      listen: false)
                                  .selectedStore = Store.FOOD;
                            } else {
                              Provider.of<SelectStoreProvider>(context,
                                      listen: false)
                                  .selectedStore = Store.COSMETICS;
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return StoreSplashScreen(isFood: widget.isFood);
                              },
                            ));
                          },
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
    );
  }
}
