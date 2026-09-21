import 'package:bunpod/bunpod.dart';
import 'package:expressive_snack/expressive_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_shapes/material_shapes.dart';
import 'package:motor/motor.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.episode,
    required this.scheme,
  });

  final Episode episode;
  final ColorScheme scheme;

  void _onTap(BuildContext context, DownloadState state) async {
    final cubit = context.read<EpisodeDownloadProgressCubit>();
    switch (state) {
      case .idle:
        await cubit.startDownload((error) {
          showExpressiveSnack(
            context: context,
            message: 'Failed to start download.',
            icon: Icons.error_rounded,
          );
        });
        break;
      case .enqueued:
      case .running:
        await cubit.pause();
        // TODO: show confirm dialog
        final confirmed = await Future.value(true);

        if (confirmed) {
          await cubit.cancel();
        } else {
          await cubit.resume();
        }

      case .completed:
        // TODO: show confiem dialog and delete download
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = scheme;
    final Color accent = cs.primary;

    return DownloadBuilder(
      episode: episode,
      builder: (context, state, progress) {
        final done = state == .completed;
        final IconData icon = done
            ? Icons.check_rounded
            : Icons.download_for_offline_outlined;

        return SingleMotionBuilder(
          // Low overshoot so the mid-stop (bun) doesn't bounce past into sunny.
          motion: const MaterialSpringMotion.standardSpatialFast(),
          value: switch (state) {
            .completed => 1.0,
            .running || .paused || .enqueued => 0.5,
            _ => 0.0,
          },
          builder: (context, t, child) {
            return ClipPath(
              clipper: ShapeBorderClipper(
                shape: _shapeAt(t),
              ),
              child: child,
            );
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: cs.surfaceContainerHighest,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Icon(
                    icon,
                    color: cs.onSurface,
                  ),
                ),
              ),
              Positioned.fill(
                child: SingleMotionBuilder(
                  value: progress ?? 0.0,
                  motion: MaterialSpringMotion.standardSpatialFast(),
                  builder: (context, value, child) => ClipRect(
                    clipper: _BottomFillClipper(value.clamp(0.0, 1.0)),
                    child: child,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ColoredBox(
                          color: accent,
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Icon(
                            icon,
                            color: cs.onPrimary,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _onTap(context, state),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // circle (idle) → bun (t=0.5) → sunny (t=1).
  ShapeBorder _shapeAt(double t) {
    final MaterialShapeBorder circle = MaterialShapeBorder(
      shape: MaterialShapes.circle,
    );
    final MaterialShapeBorder downloading = MaterialShapeBorder(
      shape: MaterialShapes.bun,
    );

    if (t <= 0) return circle;
    if (t <= 0.5) {
      final double p = t / 0.5;
      return p >= 1 ? downloading : circle.lerpTo(downloading, p)!;
    }

    final MaterialShapeBorder done = MaterialShapeBorder(
      shape: MaterialShapes.sunny,
    );
    final double p = (t - 0.5) / 0.5;

    return p >= 1 ? done : downloading.lerpTo(done, p)!;
  }
}

class _BottomFillClipper extends CustomClipper<Rect> {
  const _BottomFillClipper(this.fraction);

  final double fraction;

  @override
  Rect getClip(Size size) => Rect.fromLTWH(
    0,
    size.height * (1 - fraction),
    size.width,
    size.height * fraction,
  );

  @override
  bool shouldReclip(_BottomFillClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}
