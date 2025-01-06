import 'package:flutter/material.dart';

class CustomShapeContainer extends StatelessWidget {
  const CustomShapeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 100,
        color:
            const Color(0xFF3D348B), // Background color similar to the provided image
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double radius = 16.0;

    // Move to the starting point
    path.moveTo(radius, 0);

    // Draw top left corner
    path.quadraticBezierTo(0, 0, 0, radius);

    // Draw left side
    path.lineTo(0, size.height - radius);

    // Draw bottom left corner
    path.quadraticBezierTo(0, size.height, radius, size.height);

    // Draw bottom side
    path.lineTo(size.width, size.height);

    // Draw right side
    path.lineTo(size.width - 20, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
