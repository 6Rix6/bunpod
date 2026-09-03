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
