import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData buildThemeData({required ColorScheme colorScheme}) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        brightness: colorScheme.brightness,

        // input decoration
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: colorScheme.inversePrimary,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))),

        // icon button
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
                backgroundColor: colorScheme.surface,
                foregroundColor: colorScheme.surfaceTint)),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          elevation: 10,
        )));
  }
}


/* import 'package:ekin_app/Core/Constants/color_const.dart';
import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:flutter/material.dart';

class CThemes {
  final ThemeData darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(primary: CColors.cobaltBlue),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(
          fontSize: 15,
        ),
        labelColor: CColors.kcDeepBlue,
        unselectedLabelColor: CColors.kcwhite54,
        unselectedLabelStyle: TextStyle(fontSize: 14),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          shape: BoxShape.rectangle,
          color: CColors.kcwhite54,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: CColors.kcAppbarColor),
      textTheme:
          const TextTheme(headlineMedium: TextStyle(color: CColors.kcwhite)),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: CColors.kcDeepOcean),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: CColors.kcGeneralButtonBackC),
              borderRadius: BorderRadius.circular(20))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 8,
              textStyle: const TextStyle(fontSize: 16),
              padding: kPaddingAllSmall + kPaddingHorizontalLarge * 3,
              backgroundColor: CColors.kcGeneralButtonBackC)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: CColors.kcGeneralButtonBackC),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStatePropertyAll(kPaddingAllSmall * 1.4),
              elevation: const MaterialStatePropertyAll(8),
              foregroundColor:
                  const MaterialStatePropertyAll(CColors.kcDeepOcean),
              backgroundColor: const MaterialStatePropertyAll<Color>(
                  CColors.kcGeneralButtonBackC))));
}
*/