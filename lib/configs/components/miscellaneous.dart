// ignore_for_file: camel_case_types

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:millyshb/configs/theme/colors.dart';

class MillysHBTheme {
  static final ThemeData _instance = ThemeData.light().copyWith(
    primaryColor: const Color.fromARGB(255, 130, 110, 194), //#826EC2
    //SecondaryColor: Color.fromRGBO(236, 233, 231, 1),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color.fromARGB(255, 230, 248, 130)),
    //buttonColor: Color(0xFF1DBFAF),
  );

  static ThemeData get() {
    return _instance;
  }
}

class loadingIndicator extends StatelessWidget {
  final bool isTransParent;

  const loadingIndicator({
    this.isTransParent = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isTransParent)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.transparent,
            ),
          )
        else
          Container(
            color: Colors.white,
          ),
        const Center(
          child: SpinKitFadingCircle(
            color: Colors.blueAccent, // Replace with your Pallete.accentColor
            size: 30.0,
          ),
        ),
      ],
    );
  }
}

class TextRegularStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 14.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class bodyText {
  static const TextStyle _instance = TextStyle(
    fontSize: 16.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class TextSubRegularStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 12.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class TextPagetitleStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 21.0, //previous value 20
    // color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class TextButtonStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 18.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class TextTileStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.bold);

  static TextStyle get() {
    return _instance;
  }
}

class TextBottomStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 10.0,
      color: Colors.white,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.bold);

  static TextStyle get() {
    return _instance;
  }
}

class TextTileNumberStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 40.0,
      color: Colors.white,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.bold);

  static TextStyle get() {
    return _instance;
  }
}

class ErrorTextStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 15.0,
      color: Colors.red,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.w400);

  static TextStyle get() {
    return _instance;
  }
}

createUniqueid() {
  return DateTime.now().microsecondsSinceEpoch.remainder(2);
}
