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
        child: BlocProvider(
          create: (_) =>
              PlaybackProgressCubit(locator(), episodeId: episode.localId),
          child: _progressContainer(
            (context, data) {
              final double p = data.total.inSeconds == 0
                  ? 0.00
                  : data.listened.inSeconds / data.total.inSeconds;

              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipRect(
                      clipper: _FillClipper(start: _kFillStart, fraction: p),
                      child: ColoredBox(color: fill),
                    ),
                  ),
                  _content(context, cs, cs.onSurface, onFill, data),
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
    final bool started = listened > Duration.zero;
    final Duration remaining = total - listened;

    if (remaining <= Duration.zero) {
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
    ({Duration total, Duration listened}) progress,
  ) {
    final Episode episode = widget.episode;
    final TextTheme tt = Theme.of(context).textTheme;

    final double p = progress.total.inSeconds == 0
        ? 0.00
        : progress.listened.inSeconds / progress.total.inSeconds;

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
            _progressContainer(
              (context, progress) =>
                  _trailing(context, cs, fg, progress.total, progress.listened),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressContainer(
    Widget Function(
      BuildContext context,
      ({Duration total, Duration listened}) progress,
    )
    builder,
  ) {
    if (widget.playing) {
      return BlocSelector<
        PlayerCubit,
        PlayerState,
        ({Duration total, Duration listened})
      >(
        selector: (state) => (total: state.duration, listened: state.position),
        builder: builder,
      );
    } else {
      return BlocSelector<
        PlaybackProgressCubit,
        ViewState<Duration>,
        ({Duration total, Duration listened})
      >(
        selector: (state) {
          final position = state.dataOrNull ?? Duration.zero;
          final total = widget.episode.total;
          return (total: total, listened: position);
        },
        builder: builder,
      );
    }
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
