import "package:flutter/material.dart";

class AppTheme {
  static ColorScheme lightScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xff000000),
      surfaceTint: const Color(0xff5e5e5e),
      onPrimary: const Color(0xffffffff),
      primaryContainer: const Color(0xff262626),
      onPrimaryContainer: const Color(0xffb1b1b1),
      secondary: const Color(0xff5d5f5f),
      onSecondary: const Color(0xffffffff),
      secondaryContainer: const Color(0xffffffff),
      onSecondaryContainer: const Color(0xff575859),
      tertiary: const Color(0xff383838),
      onTertiary: const Color(0xffffffff),
      tertiaryContainer: const Color(0xff5b5b5b),
      onTertiaryContainer: const Color(0xffffffff),
      error: const Color(0xffba1a1a),
      onError: const Color(0xffffffff),
      errorContainer: const Color(0xffffdad6),
      onErrorContainer: const Color(0xff410002),
      surface: Colors.white.withOpacity(.6),
      onSurface: const Color(0xff1b1b1b),
      onSurfaceVariant: const Color(0xff4c4546),
      outline: const Color(0xff7e7576),
      outlineVariant: const Color(0xffcfc4c5),
      shadow: const Color(0xff000000),
      scrim: const Color(0xff000000),
      inverseSurface: const Color(0xff303030),
      inversePrimary: const Color(0xffc6c6c6),
      primaryFixed: const Color(0xffe2e2e2),
      onPrimaryFixed: const Color(0xff1b1b1b),
      primaryFixedDim: const Color(0xffc6c6c6),
      onPrimaryFixedVariant: const Color(0xff474747),
      secondaryFixed: const Color(0xffe2e2e2),
      onSecondaryFixed: const Color(0xff1a1c1c),
      secondaryFixedDim: const Color(0xffc6c6c7),
      onSecondaryFixedVariant: const Color(0xff454747),
      tertiaryFixed: const Color(0xffe4e2e2),
      onTertiaryFixed: const Color(0xff1b1c1c),
      tertiaryFixedDim: const Color(0xffc8c6c6),
      onTertiaryFixedVariant: const Color(0xff474747),
      surfaceDim: const Color(0xffdadada),
      surfaceBright: const Color(0xfff9f9f9),
      surfaceContainerLowest: const Color(0xffffffff),
      surfaceContainerLow: const Color(0xfff3f3f3),
      surfaceContainer: const Color(0xffeeeeee),
      surfaceContainerHigh: const Color(0xffe8e8e8),
      surfaceContainerHighest: const Color(0xffe2e2e2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc6c6c6),
      surfaceTint: Color(0xffc6c6c6),
      onPrimary: Color(0xff303030),
      primaryContainer: Color(0xff000000),
      onPrimaryContainer: Color(0xff969696),
      secondary: Color(0xffffffff),
      onSecondary: Color(0xff2f3131),
      secondaryContainer: Color(0xffd4d4d4),
      onSecondaryContainer: Color(0xff3e4040),
      tertiary: Color(0xffc8c6c6),
      onTertiary: Color(0xff303030),
      tertiaryContainer: Color(0xff424242),
      onTertiaryContainer: Color(0xffdad8d8),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131313),
      onSurface: Color(0xffe2e2e2),
      onSurfaceVariant: Color(0xffcfc4c5),
      outline: Color(0xff988e90),
      outlineVariant: Color(0xff4c4546),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e2),
      inversePrimary: Color(0xff5e5e5e),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff1b1b1b),
      primaryFixedDim: Color(0xffc6c6c6),
      onPrimaryFixedVariant: Color(0xff474747),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc6c6c7),
      onSecondaryFixedVariant: Color(0xff454747),
      tertiaryFixed: Color(0xffe4e2e2),
      onTertiaryFixed: Color(0xff1b1c1c),
      tertiaryFixedDim: Color(0xffc8c6c6),
      onTertiaryFixedVariant: Color(0xff474747),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff393939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1b1b1b),
      surfaceContainer: Color(0xff1f1f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353535),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: const TextTheme().apply(
            bodyColor: colorScheme.onSurface,
            displayColor: colorScheme.onSurface),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );
}
