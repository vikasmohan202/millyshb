import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:millyshb/models/sub_category_model.dart';
import 'package:millyshb/view/product/product_list.dart';

class ImageWidget extends StatefulWidget {
  final SubCategory subCategory;
  ImageWidget({required this.subCategory, super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductList(id: widget.subCategory.id);
          }));
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                widget.subCategory.pictureUrl,
              ),
              onBackgroundImageError: (error, stackTrace) {
                // Handle error if needed
                debugPrint('Image load error: $error');
              },
            ),
            Text(widget.subCategory.title)
          ],
        ),
      ),
    );
  }
}
