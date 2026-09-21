import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A labelled group of [DownloadTile]s in the same segmented style as
/// [MenuSection], with an optional meta line or action on the header's
/// trailing edge.
class DownloadSection extends StatelessWidget {
  const DownloadSection({
    super.key,
    required this.label,
    this.meta,
    this.action,
    required this.children,
  });

  final String label;
  final String? meta;
  final Widget? action;
  final List<Widget> children;

  static BorderRadius radiusFor(int index, int itemCount) {
    const Radius outer = .circular(MenuSection.outerRadius);
    const Radius inner = .circular(MenuSection.innerRadius);

    return .vertical(
      top: index == 0 ? outer : inner,
      bottom: index == itemCount - 1 ? outer : inner,
    );
  }

  DownloadTile _positioned(DownloadTile tile, int index) {
    return DownloadTile(
      key: tile.key,
      episode: tile.episode,
      download: tile.download,
      onTap: tile.onTap,
      onDelete: tile.onDelete,
      removing: tile.removing,
      onRemoved: tile.onRemoved,
      borderRadius: radiusFor(index, children.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Padding(
          padding: const .fromLTRB(16, 0, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.unbounded(
                    textStyle: tt.labelLarge,
                    fontWeight: .w600,
                    letterSpacing: -0.3,
                    color: cs.primary,
                  ),
                ),
              ),
              if (action != null)
                action!
              else if (meta != null)
                Text(
                  meta!,
                  style: GoogleFonts.googleSansCode(
                    textStyle: tt.labelSmall,
                    color: cs.onSurfaceVariant,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
            ],
          ),
        ),
        for (int i = 0; i < children.length; i++) ...[
          if (i > 0) MenuSection.tileGap.gap,
          if (children[i] is DownloadTile)
            _positioned(children[i] as DownloadTile, i)
          else
            children[i],
        ],
      ],
    );
  }
}
