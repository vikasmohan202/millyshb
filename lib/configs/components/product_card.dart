import 'package:flutter/material.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/product/product_details_screen.dart';

class ProductCard extends StatefulWidget {
  Product product;
  ProductCard({required this.product, super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    widget.product.discount = 5;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ProductDetailsScreen(product: widget.product);
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(14.0), // Adjust the radius as needed
            child: Image.network(
              widget.product.image,
              width: 170.0, // Set your desired width
              height: 124.0, // Set your desired height
              fit:
                  BoxFit.cover, // Set the fit property to cover the entire area
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    widget.product.description,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                (widget.product.discount == 0)
                    ? Text(
                        "\$ ${widget.product.price}",
                        style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      )
                    : Text(
                        "\$ ${(widget.product.price - widget.product.discount).toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      ),
                if (widget.product.discount != 0)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "\$ ${widget.product.price}",
                          style: const TextStyle(
                              color: Color.fromRGBO(187, 187, 187, 1),
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text:
                              ' ${((widget.product.discount / widget.product.price) * 100).toStringAsFixed(2)}%Off',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
