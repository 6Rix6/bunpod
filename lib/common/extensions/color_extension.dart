import 'package:flutter/material.dart';

extension ColorX on Color {
  ColorScheme scheme(BuildContext context) => ColorScheme.fromSeed(
    seedColor: this,
    brightness: Theme.of(context).brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.content,
  );
}
