import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_shapes/material_shapes.dart';
import 'package:material_wavy_progress_indicator/material_wavy_progress_indicator.dart';
import 'package:motor/motor.dart';

/// One downloaded episode in a grouped list: shaped cover, title, and file
/// size. Downloading rows get a wavy progress ring with the percent inside;
/// queued rows a waiting ring; played rows a check. Rows on device get a
/// trailing delete button when [onDelete] is set.
class DownloadTile extends StatelessWidget {
  const DownloadTile({
    super.key,
    required this.episode,
    required this.download,
    this.played = false,
    this.onTap,
    this.onDelete,
    this.removing = false,
    this.onRemoved,
    this.borderRadius,
    this.onRetry,
    this.onCancel,
  });

  final Episode episode;
  final DownloadProgressInfo download;
  final bool played;

  final VoidCallback? onTap;

  /// Shown as a trailing delete button on rows that are fully downloaded.
  final VoidCallback? onDelete;

  /// When flipped to true, the row plays its removal animation and calls
  /// [onRemoved] once its slot has fully closed — only then should the
  /// owner drop it from the list.
  final bool removing;
  final VoidCallback? onRemoved;

  final VoidCallback? onRetry;
  final VoidCallback? onCancel;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return RemovalCollapse(
      removing: removing,
      onRemoved: onRemoved,
      child: Material(
        color: cs.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(MenuSection.innerRadius),
        ),
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const .fromLTRB(12, 12, 16, 12),
            child: Row(
              children: [
                ClipPath(
                  clipper: ShapeBorderClipper(
                    shape: MaterialShapeBorder(shape: ShapeValues.cover),
                  ),
                  child: SizedBox(
                    width: 52,
                    height: 52,
                    child: SmoothImage(
                      url: episode.image,
                      placeholderChild: Icon(
                        Icons.podcasts_rounded,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                14.gap,
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Text(
                        episode.channel.toUpperCase(),
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: tt.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          fontWeight: .w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                      2.gap,
                      Text(
                        episode.title,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: tt.bodyLarge,
                      ),
                      if (download.hasExpectedFileSize) ...[
                        4.gap,
                        Text(
                          sizeLabel(
                            download.expectedFileSize ~/ (1024 * 1024), // MB,
                          ),
                          style: GoogleFonts.googleSansCode(
                            textStyle: tt.labelSmall,
                            color: cs.onSurfaceVariant,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                12.gap,
                ?_trailing(context, cs),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _trailing(BuildContext context, ColorScheme cs) {
    switch (download.state) {
      case .running:
      case .paused:
        return InkResponse(
          onTap: onCancel,
          radius: 26,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: .center,
              children: [
                SingleMotionBuilder(
                  value: download.progress,
                  motion: MaterialSpringMotion.standardSpatialFast(),
                  builder: (context, value, child) {
                    return CircularWavyProgressIndicator(
                      value: value.clamp(0.0, 1.0),
                    );
                  },
                ),
                Icon(
                  Icons.stop_rounded,
                  size: 20,
                  color: cs.primary,
                ),
              ],
            ),
          ),
        );
      case .enqueued:
      case .waitingToRetry:
        return SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: .center,
            children: [
              const CircularWavyProgressIndicator(value: 0),
              Icon(
                Icons.hourglass_top_rounded,
                size: 18,
                color: cs.onSurfaceVariant,
              ),
            ],
          ),
        );
      case .completed:
        final Widget? deleteButton = onDelete == null
            ? null
            : _DeleteButton(onPressed: onDelete!);

        if (!played) return deleteButton;

        return Row(
          mainAxisSize: .min,
          children: [
            _InfoIcon(
              icon: Icons.check_rounded,
              backgroundColor: cs.tertiaryContainer,
              iconColor: cs.onTertiaryContainer,
              label: 'Played',
            ),
            if (deleteButton != null) ...[
              4.gap,
              deleteButton,
            ],
          ],
        );
      case .failed:
      case .canceled:
      case .notFound:
        if (onRetry == null && onCancel == null) {
          return SizedBox.shrink();
        }
        return ExpressiveMenu.standard(
          width: 160,
          items: [
            if (onRetry != null)
              ExpressiveMenuItem(
                label: 'Retry',
                icon: Icons.refresh_rounded,
                onPressed: onRetry,
              ),
            if (onCancel != null)
              ExpressiveMenuItem(
                label: 'Cancel',
                icon: Icons.close_rounded,
                onPressed: onCancel,
              ),
          ],
          builder: (context, c) {
            return IconButton(
              onPressed: () => c.isOpen ? c.close() : c.open(),
              icon: _InfoIcon(
                icon: Icons.error_outline_rounded,
                backgroundColor: cs.errorContainer,
                iconColor: cs.onErrorContainer,
                label: download.state.name,
                containerSize: 36,
                iconSize: 20,
              ),
            );
          },
        );
      case .idle:
        return SizedBox.shrink();
    }
  }
}

/// Trailing delete affordance on a downloaded row. At rest it's a quiet
/// outlined icon; while pressed, an error-container blob springs in behind
/// it and morphs from a circle into [MaterialShapes.sunny] — the same
/// destructive shape as [StyledSheet]'s hero icon, so the press previews
/// the confirmation it opens.
class _DeleteButton extends StatefulWidget {
  const _DeleteButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<_DeleteButton> {
  bool _pressed = false;

  // M3 motion splits by property: shape and scale are spatial (overshoot
  // into place), color is an effect (settles without overshoot). Press-in
  // leads with the expressive springs; release settles on standard fast,
  // like the spring sheet's exit.
  static const Motion _spatialIn = MaterialSpringMotion.expressiveSpatialFast();
  static const Motion _spatialOut = MaterialSpringMotion.standardSpatialFast();
  static const Motion _effectIn = MaterialSpringMotion.expressiveEffectsFast();
  static const Motion _effectOut = MaterialSpringMotion.standardEffectsFast();

  static final MaterialShapeBorder _circle = MaterialShapeBorder(
    shape: MaterialShapes.circle,
  );
  static final MaterialShapeBorder _sunny = MaterialShapeBorder(
    shape: MaterialShapes.sunny,
  );

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final double target = _pressed ? 1 : 0;

    return Tooltip(
      message: 'Remove download',
      child: InkResponse(
        onTap: widget.onPressed,
        onHighlightChanged: (highlighted) {
          setState(() => _pressed = highlighted);
        },
        radius: 26,
        // The blob is the press feedback; a ripple underneath would fight it.
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SingleMotionBuilder(
          value: target,
          motion: _pressed ? _spatialIn : _spatialOut,
          builder: (context, spatial, child) {
            return SingleMotionBuilder(
              value: target,
              motion: _pressed ? _effectIn : _effectOut,
              builder: (context, effect, child) {
                final double fade = effect.clamp(0.0, 1.0);

                return SizedBox(
                  width: 44,
                  height: 44,
                  child: Center(
                    child: Transform.scale(
                      // Spring overshoot pushes past 1, so the sunny points
                      // flare slightly before settling.
                      scale: 1 + 0.12 * spatial,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: ShapeDecoration(
                          color: cs.errorContainer.withValues(alpha: fade),
                          shape:
                              ShapeBorder.lerp(_circle, _sunny, spatial) ??
                              _circle,
                        ),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          size: 20,
                          color: Color.lerp(
                            cs.onSurfaceVariant,
                            cs.onErrorContainer,
                            fade,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.label,
    this.containerSize = 28,
    this.iconSize,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String? label;
  final double containerSize;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      width: containerSize,
      height: containerSize,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: MaterialShapeBorder(
          shape: MaterialShapes.cookie7Sided,
        ),
      ),
      child: Icon(
        icon,
        size: iconSize ?? containerSize - 12,
        color: iconColor,
      ),
    );

    if (label != null) {
      child = Tooltip(
        message: label,
        child: child,
      );
    }

    return child;
  }
}
