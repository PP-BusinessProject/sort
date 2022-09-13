import 'dart:ui';

import 'package:control_style/control_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The [BoxShadow] that depends on [theme].
BoxShadow boxShadow(final ThemeData theme) => BoxShadow(
      color: theme.colorScheme.shadow,
      blurRadius: 8,
      spreadRadius: -1 / 2,
      offset: const Offset(0, 4),
    );

/// The [InputBorder] that depends on [theme].
InputBorder inputBorder(
  final ThemeData theme, {
  final double radius = 12,
}) =>
    DecoratedInputBorder(
      shadow: <BoxShadow>[boxShadow(theme)],
      child: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
    );

/// The [OutlinedBorder] that depends on [theme].
OutlinedBorder outlinedBorder(
  final ThemeData theme, {
  final double radius = 12,
}) =>
    DecoratedOutlinedBorder(
      shadow: <BoxShadow>[boxShadow(theme)],
      child:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    );

/// The [ImageFilter] used as a blur.
final ImageFilter blur = ImageFilter.blur(sigmaX: 32, sigmaY: 32);

/// The [ImageFilter] used as a background blur.
final ImageFilter backgroundBlur = ImageFilter.blur(sigmaX: 64, sigmaY: 64);

/// The [Brightness.light] [ColorScheme] used as a default.
const ColorScheme lightScheme = ColorScheme.light(
  background: Color(0xffFAFAFA),
  onPrimary: Color(0xff79D682),
  primary: Color(0xffC9EACC),
  secondary: Color(0xffF9E8BC),
  primaryContainer: Color(0xffD7E7D9),
  error: Color(0xffEC554C),
  tertiary: Color(0xff5FB464),
  shadow: Color(0x40000000),
  surfaceTint: Color(0xff8F8F8F),
  outline: Color(0xff9D9D9D),
);

/// The [Brightness.dark] [ColorScheme] used as a default.
const ColorScheme darkScheme = ColorScheme.dark(
  background: Color(0xff222222),
  surface: Color(0xff8F8F8F),
  primary: Color(0xff607860),
  onPrimary: Color(0xff79D682),
  secondary: Color(0xff9B8D69),
  primaryContainer: Color(0xffD7E7D9),
  error: Color(0xffA1403A),
  tertiary: Color(0xff73B676),
  shadow: Color(0x40000000),
  surfaceTint: Color(0xff6D6C6C),
  outline: Color(0xffBDBDBD),
);

/// The `Material3` [TextTheme] used as a default.
final TextTheme textTheme = const TextTheme(
  displayLarge: TextStyle(
    fontSize: 60,
    height: 64 / 60,
    fontWeight: FontWeight.normal,
  ),
  displayMedium: TextStyle(
    fontSize: 44,
    height: 48 / 44,
    fontWeight: FontWeight.normal,
  ),
  displaySmall: TextStyle(
    fontSize: 28,
    height: 32 / 28,
    fontWeight: FontWeight.normal,
  ),
  headlineLarge: TextStyle(
    fontSize: 22,
    height: 22 / 22,
    fontWeight: FontWeight.w500,
  ),
  headlineMedium: TextStyle(
    fontSize: 20,
    height: 22 / 20,
    fontWeight: FontWeight.w500,
  ),
  headlineSmall: TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w500,
  ),
  titleLarge: TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.normal,
  ),
  titleMedium: TextStyle(
    fontSize: 14,
    height: 24 / 14,
    fontWeight: FontWeight.normal,
  ),
  titleSmall: TextStyle(
    fontSize: 12,
    height: 24 / 12,
    fontWeight: FontWeight.normal,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    height: 16 / 16,
    fontWeight: FontWeight.normal,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    height: 16 / 14,
    fontWeight: FontWeight.normal,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.normal,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    height: 14 / 14,
    fontWeight: FontWeight.normal,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    height: 14 / 12,
    fontWeight: FontWeight.normal,
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    height: 14 / 10,
    fontWeight: FontWeight.normal,
  ),
).apply(fontFamily: '.SF Pro Text');

/// Apply additional properties on a [ThemeData].
extension ApplyThemeData on ThemeData {
  /// Apply additional properties on a [ThemeData].
  ThemeData apply() => copyWith(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        dividerColor: Colors.transparent,
        scaffoldBackgroundColor: colorScheme.background,
        disabledColor: colorScheme.primaryContainer,
        splashColor: colorScheme.shadow.withOpacity(1 / 10),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          toolbarHeight: 70,
        ),
        dialogTheme: DialogTheme(elevation: 16, shape: inputBorder(this)),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorScheme.onPrimary,
          selectionColor: colorScheme.onPrimary,
          selectionHandleColor: colorScheme.onPrimary,
        ),
        iconTheme: IconThemeData(size: 24, color: colorScheme.onSurface),
        tooltipTheme: TooltipThemeData(
          textStyle: textTheme.bodyMedium,
          waitDuration: const Duration(seconds: 1),
          showDuration: const Duration(seconds: 5),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[boxShadow(this)],
          ),
        ),
        radioTheme: RadioThemeData(
          splashRadius: 16,
          fillColor: MaterialStateProperty.all<Color?>(colorScheme.primary),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        buttonTheme: ButtonThemeData(
          alignedDropdown: true,
          minWidth: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          shape: outlinedBorder(this, radius: 10),
          buttonColor: colorScheme.primary,
          disabledColor: colorScheme.primaryContainer,
          splashColor: colorScheme.onPrimary,
          highlightColor: colorScheme.onPrimary,
          focusColor: colorScheme.onPrimary,
          hoverColor: colorScheme.onPrimary,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            shape: outlinedBorder(this, radius: 10),
            primary: colorScheme.primary,
            textStyle: textTheme.headlineMedium,
            splashFactory: NoSplash.splashFactory,
          ).apply(this),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            shape: outlinedBorder(this, radius: 10),
            primary: colorScheme.primary,
            onPrimary: colorScheme.onSurface,
            textStyle: textTheme.headlineSmall,
            splashFactory: NoSplash.splashFactory,
          ).apply(this, foregroundColor: colorScheme.onSurface),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onSurface: colorScheme.onPrimary,
            textStyle: textTheme.labelLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
            splashFactory: NoSplash.splashFactory,
          ).apply(this, foregroundColor: colorScheme.onPrimary),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.zero,
          fillColor: brightness == Brightness.light
              ? colorScheme.primary
              : colorScheme.surfaceTint,
          border: inputBorder(this),
          enabledBorder: inputBorder(this),
          disabledBorder: inputBorder(this),
          errorBorder: inputBorder(this),
          focusedBorder: inputBorder(this),
          focusedErrorBorder: inputBorder(this),
          hintStyle: textTheme.headlineSmall,
          errorStyle: textTheme.headlineSmall,
          labelStyle: textTheme.headlineSmall,
          helperStyle: textTheme.headlineSmall,
          prefixStyle: textTheme.headlineSmall,
          suffixStyle: textTheme.headlineSmall,
          counterStyle: textTheme.headlineSmall,
          floatingLabelStyle: textTheme.headlineSmall,
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: brightness,
          primaryColor: colorScheme.primary,
          primaryContrastingColor: colorScheme.onPrimary,
          scaffoldBackgroundColor: colorScheme.background,
          barBackgroundColor: Colors.transparent,
          textTheme: CupertinoTextThemeData(
            primaryColor: colorScheme.onPrimary,
            actionTextStyle:
                textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
            navTitleTextStyle:
                textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
            navActionTextStyle:
                textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
      );
}

extension on ButtonStyle {
  ButtonStyle apply(final ThemeData theme, {final Color? foregroundColor}) =>
      copyWith(
        foregroundColor: MaterialStateProperty.resolveWith(
          (final Set<MaterialState> states) =>
              states.contains(MaterialState.disabled)
                  ? theme.colorScheme.surfaceTint
                  : foregroundColor,
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (final Set<MaterialState> states) =>
              states.contains(MaterialState.pressed) ? theme.splashColor : null,
        ),
      );
}
