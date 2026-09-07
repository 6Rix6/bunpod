import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';

class ExploreItemPill extends StatelessWidget {
  const ExploreItemPill({
    super.key,
    required this.item,
    required this.onClear,
  });

  final ExploreItem item;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = item.scheme(context);
    final TextTheme tt = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: scheme.primaryContainer,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onClear,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 10, 8),
            child: Row(
              mainAxisSize: .min,
              children: [
                Text(
                  item.name,
                  style: tt.labelLarge?.copyWith(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                6.gap,
                Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: scheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
