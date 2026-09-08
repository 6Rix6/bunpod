import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_shapes/material_shapes.dart';
import 'package:motor/motor.dart';

class EpisodeCard extends StatefulWidget {
  const EpisodeCard({
    super.key,
    required this.episode,
    required this.playing,
    required this.onTap,
  });

  final Episode episode;
  final bool playing;
  final VoidCallback onTap;

  static const double height =
      _EpisodeCardState.coverSize + _EpisodeCardState.cardPadding * 2;

  @override
  State<EpisodeCard> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends State<EpisodeCard> {
  static const double coverSize = 56.0;
  static const double cardPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    final Episode episode = widget.episode;
    final bool playing = widget.playing;
    final ColorScheme cs = episode.scheme(context);
    final double progress = episode.progress;

    final Color fill = cs.primary;
    final Color onFill = cs.onPrimary;

    return RepaintBoundary(
      child: SingleMotionBuilder(
        motion: const MaterialSpringMotion.standardSpatialFast(),
        value: playing ? 1.0 : 0.0,
        builder: (context, t, child) {
          final double radius = 24 + (40 - 24) * t;
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(radius < 0 ? 0 : radius),
            ),
            child: child,
          );
        },
        child: BlocSelector<PlayerCubit, PlayerState, double>(
          selector: (state) {
            return state.episode == episode ? state.progress : progress;
          },
          builder: (context, p) {
            return Stack(
              children: [
                Positioned.fill(
                  child: ClipRect(
                    clipper: _FillClipper(start: _kFillStart, fraction: p),
                    child: ColoredBox(color: fill),
                  ),
                ),
                _content(context, cs, cs.onSurface, onFill, p),
                Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: _cover(cs),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(onTap: widget.onTap),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _trailing(
    BuildContext context,
    ColorScheme cs,
    Color fg,
    Duration total,
    Duration listened,
  ) {
    final Episode episode = widget.episode;

    if (episode.progress >= 1.0) {
      return Container(
        width: 30,
        height: 30,
        decoration: ShapeDecoration(
          color: fg,
          shape: MaterialShapeBorder(
            shape: MaterialShapes.cookie7Sided,
          ),
        ),
        child: Icon(
          Icons.check_rounded,
          size: 18,
          color: cs.primary,
        ),
      );
    }

    final bool started = listened > Duration.zero;
    final Duration remaining = total - listened;

    return Text(
      started ? '-${remaining.remainingLabel}' : remaining.remainingLabel,
      style: GoogleFonts.unbounded(
        color: fg,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  Widget _cover(ColorScheme cs, {bool placeholder = false}) {
    if (placeholder) {
      return SizedBox.square(
        dimension: coverSize,
      );
    }

    final Episode episode = widget.episode;

    return SingleMotionBuilder(
      motion: const MaterialSpringMotion.standardSpatialFast(),
      value: widget.playing ? 1.0 : 0.0,
      builder: (context, t, child) => ClipPath(
        clipBehavior: Clip.hardEdge,
        clipper: ShapeBorderClipper(
          shape: ShapeValues.coverBorder(t),
        ),
        child: child,
      ),
      child: SizedBox.square(
        dimension: coverSize,
        child: _Cover(
          episode: episode,
          scheme: cs,
          size: coverSize,
        ),
      ),
    );
  }

  Widget _content(
    BuildContext context,
    ColorScheme cs,
    Color fg,
    Color bg,
    double p,
  ) {
    final Episode episode = widget.episode;
    final TextTheme tt = Theme.of(context).textTheme;

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        final double stop = p.clamp(0.0, 1.0);
        return LinearGradient(
          colors: [bg, bg, fg, fg],
          stops: [0.0, stop, stop, 1.0],
        ).createShader(bounds);
      },
      child: Padding(
        padding: const EdgeInsets.all(cardPadding),
        child: Row(
          children: [
            // placeholder for cover
            _cover(cs, placeholder: true),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    episode.channel.toUpperCase(),
                    style: tt.labelSmall?.copyWith(
                      color: fg,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  const SizedBox(height: 2),
                  MarqueeText(
                    text: episode.title,
                    style: tt.titleMedium?.copyWith(
                      color: fg,
                      fontWeight: FontWeight.w700,
                    ),
                    playing: widget.playing,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            BlocSelector<
              PlayerCubit,
              PlayerState,
              (Duration total, Duration listened)
            >(
              selector: (state) {
                if (state.episode == episode) {
                  return (state.duration, state.position);
                } else {
                  return (episode.total, episode.listened);
                }
              },
              builder: (context, value) =>
                  _trailing(context, cs, fg, value.$1, value.$2),
            ),
          ],
        ),
      ),
    );
  }
}

const double _kFillStart = 0;

class _FillClipper extends CustomClipper<Rect> {
  const _FillClipper({required this.start, required this.fraction});
  final double start;
  final double fraction;

  @override
  Rect getClip(Size size) => Rect.fromLTWH(
    start,
    0,
    (size.width - start) * fraction,
    size.height,
  );

  @override
  bool shouldReclip(_FillClipper oldClipper) =>
      oldClipper.start != start || oldClipper.fraction != fraction;
}

class _Cover extends StatelessWidget {
  const _Cover({
    required this.episode,
    required this.scheme,
    required this.size,
  });
  final Episode episode;
  final ColorScheme scheme;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SmoothImage(
      url: episode.image,
      width: size,
      height: size,
      placeholderColor: scheme.primaryContainer,
      placeholderChild: Icon(
        Icons.podcasts_rounded,
        color: scheme.onPrimaryContainer,
      ),
      errorChild: Icon(
        Icons.podcasts_rounded,
        color: scheme.onPrimaryContainer,
      ),
    );
  }
}
