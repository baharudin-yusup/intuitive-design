import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

class IntuitiveTheme {
  final ColorScheme lightColorScheme;
  final ColorScheme darkColorScheme;

  IntuitiveTheme({
    ColorScheme? light,
    ColorScheme? dark,
    Color? fallbackLightColor,
    Color? fallbackDarkColor,
  })  : lightColorScheme = light ??
            ColorScheme.fromSeed(
                seedColor: fallbackLightColor ?? const Color(0xff424242),
                brightness: Brightness.light),
        darkColorScheme = dark ??
            ColorScheme.fromSeed(
                seedColor: fallbackDarkColor ?? const Color(0xff424242),
                brightness: Brightness.dark);

  ThemeData get lightTheme => _getData(lightColorScheme, darkColorScheme);

  ThemeData get darkTheme => _getData(darkColorScheme, lightColorScheme);

  ThemeData _getData(ColorScheme colorScheme, ColorScheme colorSchemeInvert) {
    final base = ThemeData(colorScheme: colorScheme);
    final textTheme = GoogleFonts.robotoTextTheme(base.textTheme).copyWith(
      caption: GoogleFonts.roboto(fontSize: 9),
    );

    final textThemeInvert =
        GoogleFonts.robotoTextTheme(ThemeData(colorScheme: colorSchemeInvert).textTheme).copyWith(
      caption: GoogleFonts.roboto(fontSize: 9),
    );

    return base.copyWith(
      colorScheme: colorScheme,
      textTheme: textTheme,
      primaryIconTheme: IconThemeData(color: colorSchemeInvert.onPrimary),
      primaryTextTheme: textThemeInvert,
      navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all<TextStyle>(textTheme.subtitle1!)),
      appBarTheme: AppBarTheme(
        elevation: 2,
        backgroundColor: colorScheme.background,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        centerTitle: false,
        titleTextStyle: TextStyle(color: colorScheme.onBackground),
        titleSpacing: IntuitiveConstant.appBarSpacing,
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
      dividerTheme: const DividerThemeData(space: 5, thickness: 5, color: Colors.transparent),
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
          textStyle: textTheme.titleSmall,
        ),
      ),
      iconTheme: const IconThemeData(size: 22.5),
      cardTheme: CardTheme(
        elevation: 2,
        color: colorScheme.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IntuitiveConstant.radius),
        ),
      ),
      tabBarTheme:
          TabBarTheme(labelColor: colorScheme.primary, unselectedLabelColor: colorScheme.secondary),
    );
  }
}
