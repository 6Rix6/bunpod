import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';

class SchemeCache {
  static final Map<(int, Brightness), ColorScheme> _cache = {};

  static ColorScheme of(BuildContext context, int colorValue) {
    final Brightness brightness = Theme.of(context).brightness;
    final key = (colorValue, brightness);
    return _cache[key] ??= Color(colorValue).scheme(context);
  }
}

class ImageColorCache {
  static final int defaultColor = Colors.grey.toARGB32();
  static final Map<String, int> _cache = {};

  static Future<int> of(String url) async {
    if (_cache[url] != null) {
      return _cache[url]!;
    }

    final color = (await getColorsFromNetworkImage(
      url,
    )).firstOrNull?.toARGB32();

    if (color != null) {
      _cache[url] = color;
    }

    return color ?? defaultColor;
  }
}
