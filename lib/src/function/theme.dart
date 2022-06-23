import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

class VenraTheme {
  final ColorScheme _light;
  final ColorScheme _dark;

  VenraTheme({
    ColorScheme? light,
    ColorScheme? dark,
    Color? fallbackLightColor,
    Color? fallbackDarkColor,
  })  : _light = light ??
            ColorScheme.fromSeed(
                seedColor: fallbackLightColor ?? const Color(0xff424242),
                brightness: Brightness.light),
        _dark = dark ??
            ColorScheme.fromSeed(
                seedColor: fallbackDarkColor ?? const Color(0xff424242),
                brightness: Brightness.dark);

  ThemeData get lightTheme => _getData(_light, _dark);

  ThemeData get darkTheme => _getData(_dark, _light);

  ThemeData _getData(ColorScheme colorScheme, ColorScheme colorSchemeInvert) {
    final base = ThemeData(colorScheme: colorScheme);
    final textTheme =
        GoogleFonts.robotoTextTheme(ThemeData(colorScheme: colorScheme).textTheme).copyWith(
      caption: GoogleFonts.roboto(fontSize: 9),
    );

    final textThemeInvert =
        GoogleFonts.robotoTextTheme(ThemeData(colorScheme: colorSchemeInvert).textTheme).copyWith(
      caption: GoogleFonts.roboto(fontSize: 9),
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      primaryIconTheme: IconThemeData(color: colorSchemeInvert.onPrimary),
      primaryTextTheme: textThemeInvert,
      navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all<TextStyle>(textTheme.subtitle1!)),
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   selectedLabelStyle: textTheme.bodyText1,
      //   unselectedLabelStyle: textTheme.bodyText1,
      // ),
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.titleMedium,
        iconTheme: IconThemeData(
          color: colorScheme.primary,
        ),
        backgroundColor: colorScheme.surface,
        titleSpacing: IntuitiveConstant.appBarSpacing,
        // titleTextStyle: h6,
        // toolbarTextStyle: b1.copyWith(color: Colors.black),
        centerTitle: true,
        elevation: 0.5,
        // backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        extendedSizeConstraints: const BoxConstraints(minHeight: 50, maxHeight: 50),
        sizeConstraints: BoxConstraints.tight(const Size(50, 50)),
        extendedIconLabelSpacing: 15,
      ),

      // backgroundColor: const Color(0xffFFFFFF),
      // scaffoldBackgroundColor: const Color(0xffF5F5F5),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
          // primary: const Color(0xffA0522D),
          // onSurface: const Color(0xffd6c07f),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(IntuitiveConstant.radius),
          ),
          // elevation: 0.0,
        ),
      ),
      dividerTheme:
          DividerThemeData(space: 5, thickness: 5, color: colorScheme.shadow.withOpacity(0.06)),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          alignment: Alignment.center,
          elevation: 0,
          side: BorderSide(color: base.colorScheme.outline, width: 0.5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(IntuitiveConstant.radius),
            ),
          ),
          // primary: primary,
          textStyle: textTheme.titleSmall,
        ),
      ),
      listTileTheme: const ListTileThemeData(
          // selectedTileColor: _colorScheme.secondaryContainer,
          // tileColor: Colors.white,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          // selectedColor: Colors.white,
          // textColor: Colors.black,
          ),
      iconTheme: const IconThemeData(size: 22.5),
    );
  }
}
