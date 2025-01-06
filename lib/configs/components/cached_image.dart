import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    this.borderRadius = 0.0,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder ??
            Center(
              child: CircularProgressIndicator(),
            ),
        errorWidget: (context, url, error) => errorWidget ??
            Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
      ),
    );
  }
}
