import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../generated/assets.g.dart';
import '../../styles.dart';

/// Return the custom [Divider] widget with [width] and [height] specified.
Widget divider({required final double width, final double height = 4}) =>
    Material(
      color: const Color(0xFFC4C4C4),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: SizedBox(height: height, width: width),
    );

/// Return the custom [ListView] that scrolls only when needed.
Widget listView(
  final MediaQueryData mediaQuery, {
  required final List<Widget> children,
  final EdgeInsetsGeometry padding = const EdgeInsets.all(24),
  final Alignment alignment = Alignment.center,
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
}) =>
    SafeArea(
      child: Align(
        alignment: alignment,
        child: SingleChildScrollView(
          key: ValueKey<Orientation>(mediaQuery.orientation),
          physics: const ClampingScrollPhysics(),
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ),
    );

/// Return the widget that uses [Marquee] to display a [text] overflow.
Widget marqueeText(
  final String text, {
  final TextStyle? style,
  final int? maxLines,
}) =>
    AutoSizeText(
      text,
      minFontSize: style?.fontSize ?? 14,
      style: style,
      maxLines: maxLines,
      overflowReplacement: Marquee(
        text: text,
        style: style,
        velocity: 20,
        blankSpace: 20,
        startAfter: const Duration(seconds: 2),
        pauseAfterRound: const Duration(seconds: 3),
      ),
    );

/// Return the shared navigation bar in all screens.
CupertinoNavigationBar navigationBar(
  final ThemeData theme, {
  final VoidCallback? onPressed,
  final String? previousPageTitle,
  final Widget? trailing,
}) =>
    CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      automaticallyImplyLeading: false,
      automaticallyImplyMiddle: false,
      brightness: theme.brightness,
      border: const Border(),
      padding: const EdgeInsetsDirectional.only(start: 4),
      trailing: trailing,
      leading: OverflowBox(
        maxWidth: double.infinity,
        alignment: AlignmentDirectional.centerStart,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: CupertinoNavigationBarBackButton(
            previousPageTitle: previousPageTitle,
            onPressed: onPressed,
          ),
        ),
      ),
    );

/// Return the basic [Image] with placeholder support.
Widget image(final String? imageUrl) => imageUrl == null
    ? placeholderImage()
    : CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        // progressIndicatorBuilder:
        //     (final _, final __, final DownloadProgress progress) =>
        //         const CircularProgressIndicator.adaptive(),
        placeholder: (final _, final __) => placeholderImage(),
        errorWidget: (final _, final __, final Object? error) =>
            placeholderImage(),
      );

/// Return the [Placeholder] for the [image].
Widget placeholderImage({final double logoHeight = 40}) => ColoredBox(
      color: const Color(0xFFC4C4C4),
      child: Center(
        child: Image.asset(assets.logo, height: logoHeight),
      ),
    );

/// Return the [Widget] for displaying eco coin [balance].
Widget ecoCoinBalance(final ThemeData theme, {required final double balance}) {
  final TextStyle? ecoCoinTextStyle = theme.textTheme.titleLarge;
  final double iconSize;
  if (ecoCoinTextStyle?.fontSize != null) {
    iconSize = ecoCoinTextStyle!.fontSize! * (ecoCoinTextStyle.height ?? 1);
  } else {
    iconSize = 16;
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        balance.toStringAsFixed(0).padLeft(6),
        style: ecoCoinTextStyle,
      ),
      Image.asset(
        assets.ecocoin,
        width: iconSize,
        height: iconSize,
      ),
    ],
  );
}

/// Return the custom [IconButton].
Widget iconButton(
  final ThemeData theme,
  final IconData icon, {
  final double? iconSize,
  final Color? iconColor,
  final double? radius,
  final Color? color,
  final VoidCallback? onTap,
}) {
  final double $iconSize = iconSize ?? theme.iconTheme.size ?? 24;
  return DecoratedBox(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[boxShadow(theme)],
    ),
    child: Material(
      type: MaterialType.circle,
      clipBehavior: Clip.hardEdge,
      color: color ?? theme.colorScheme.primary,
      child: InkWell(
        onTap: onTap,
        splashFactory: NoSplash.splashFactory,
        child: Padding(
          padding: EdgeInsets.all(((radius ?? $iconSize) * 2 - $iconSize) / 2),
          child: Icon(
            icon,
            color: iconColor,
            size: (theme.iconTheme.size ?? 24) * ($iconSize / 24),
          ),
        ),
      ),
    ),
  );
}
