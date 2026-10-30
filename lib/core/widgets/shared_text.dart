import 'package:flutter/material.dart';

enum AppTextSize { small, body, medium, title, headline }

class AppText extends StatelessWidget {
  final String text;
  final AppTextSize size;
  final FontWeight fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double lineHeight;

  const AppText({
    super.key,
    required this.text,
    this.size = AppTextSize.body,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.lineHeight = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;

    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle?.copyWith(
        fontSize: _fontSize(context),
        fontWeight: fontWeight,
        color: color ?? baseStyle.color,
        height: lineHeight,
        decoration: decoration,
      ),
    );
  }

  double _fontSize(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (size) {
      case AppTextSize.small:
        return textTheme.labelSmall!.fontSize!;
      case AppTextSize.body:
        return textTheme.bodyMedium!.fontSize!;
      case AppTextSize.medium:
        return textTheme.titleSmall!.fontSize!;
      case AppTextSize.title:
        return textTheme.titleLarge!.fontSize!;
      case AppTextSize.headline:
        return textTheme.headlineSmall!.fontSize!;
    }
  }
}
