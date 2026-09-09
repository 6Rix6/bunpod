import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WavySlider extends StatefulWidget {
  const WavySlider({
    super.key,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.label,
    this.themeData,
    this.wavy = true,
    this.amplitude = 4.0,
    this.wavelength = 30.0,
    this.waveSpeed = 25.0,
    this.trackGap = 6.0,
    this.fullAmplitudeMin = 0.08,
    this.fullAmplitudeMax = 0.92,
  });

  final double value;
  final double min;
  final double max;

  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;

  final String? label;

  final SliderThemeData? themeData;

  final bool wavy;

  final double amplitude;
  final double wavelength;
  final double waveSpeed;
  final double trackGap;

  // The wave only shows at full amplitude while the value is comfortably
  // away from both ends of the
  final double fullAmplitudeMin;
  final double fullAmplitudeMax;

  @override
  State<WavySlider> createState() => _WavySliderState();

  double get _progress {
    if (max - min <= 0) return 0;
    return (value - min) / (max - min);
  }

  bool get shouldWave =>
      wavy && _progress >= fullAmplitudeMin && _progress <= fullAmplitudeMax;
}

class _WavySliderState extends State<WavySlider> with TickerProviderStateMixin {
  double get _amplitude => widget.amplitude;
  double get _wavelength => widget.wavelength;
  double get _waveSpeed => widget.waveSpeed; // logical pixels per second
  double get _trackGap => widget.trackGap;

  late final AnimationController _waveOffsetController = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: ((_wavelength / _waveSpeed) * 1000).round(),
    ),
  )..repeat();
  late final Animation<double> _waveOffsetAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_waveOffsetController);

  late final AnimationController _amplitudeFractionController =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
  late final Animation<double> _amplitudeFraction = CurvedAnimation(
    parent: _amplitudeFractionController,
    curve: const Cubic(0.2, 0, 0, 1),
    reverseCurve: const Cubic(0.3, 0, 0.8, 0.15),
  );

  double get _value => widget.value;
  bool get _shouldWave => widget.shouldWave;

  // Created exactly once and reused for the lifetime of this State. A
  // WavySliderTrackShape attaches a repaint listener to `waveOffset` /
  // `amplitudeFraction` the first time it paints; recreating a new instance
  // every build would leak one listener per rebuild, since the old
  // instance's listener is never detached. Only rebuild it if the wave
  // geometry itself needs to change at runtime.
  late final WavySliderTrackShape _trackShape = WavySliderTrackShape(
    waveOffset: _waveOffsetAnimation,
    amplitudeFraction: _amplitudeFraction,
    amplitude: _amplitude,
    wavelength: _wavelength,
    trackGap: _trackGap,
  );

  @override
  void initState() {
    super.initState();
    _amplitudeFractionController.value = _shouldWave ? 1 : 0;
  }

  @override
  void dispose() {
    _waveOffsetController.dispose();
    _amplitudeFractionController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WavySlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool waved = oldWidget.shouldWave;
    final bool shouldWave = _shouldWave;

    final bool needsUpdata = waved != shouldWave;

    if (!needsUpdata) return;

    if (shouldWave) {
      _amplitudeFractionController.forward();
    } else {
      _amplitudeFractionController.reverse();
    }
  }

  void _onChanged(double value) {
    widget.onChanged?.call(value);
  }

  void _onChangeStart(double value) {
    _amplitudeFractionController.reverse();
    widget.onChangeStart?.call(value);
  }

  void _onChangeEnd(double value) {
    if (_shouldWave) {
      _amplitudeFractionController.forward();
    }
    widget.onChangeEnd?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onChanged != null;

    return SliderTheme(
      data: (widget.themeData ?? SliderTheme.of(context)).copyWith(
        trackShape: _trackShape,
        overlayShape: SliderComponentShape.noOverlay,
        thumbSize: WidgetStatePropertyAll(Size(4, 24)),
        thumbShape: HandleThumbShape(),
        valueIndicatorShape: RoundedRectSliderValueIndicatorShape(),
      ),
      child: Slider(
        value: _value,
        min: widget.min,
        max: widget.max,
        onChanged: enabled ? _onChanged : null,
        onChangeStart: enabled ? _onChangeStart : null,
        onChangeEnd: enabled ? _onChangeEnd : null,
        label: widget.label,
      ),
    );
  }
}

/// A [SliderTrackShape] that draws the active/inactive track as a wavy line,
/// using the same "cut a segment out of a pre-built full-length wave path"
/// technique as `WavyLinearProgressIndicator`.
///
/// A [SliderTrackShape] is normally long-lived (it's typically created once,
/// e.g. as a field of a [SliderThemeData], not rebuilt every frame) and has
/// no [TickerProvider] of its own. Because of that, this class does **not**
/// own any [AnimationController]: the wave's horizontal phase and its
/// amplitude fade in/out are expected to be driven from the outside via
/// [waveOffset] and [amplitudeFraction] — exactly the two pieces of mutable
/// state (`_waveOffset` / `_amplitudeFraction`) that
/// `WavyLinearProgressIndicator`'s `State` keeps for itself. Whoever creates
/// this track shape (typically a `State` mixed with
/// `TickerProviderStateMixin`) should own the corresponding
/// [AnimationController]s and pass their current value down through these
/// two [ValueListenable]s.
///
/// Minimal wiring example:
///
/// ```dart
/// class _MySliderState extends State<MySlider>
///     with TickerProviderStateMixin {
///   late final _waveOffsetController = AnimationController(vsync: this)
///     ..repeat();
///   late final _waveOffsetTween = Tween<double>(begin: 0, end: 1)
///       .animate(_waveOffsetController);
///
///   late final _amplitudeFractionController = AnimationController(
///     vsync: this,
///     duration: const Duration(milliseconds: 500),
///   )..value = 1;
///
///   late final _trackShape = WavySliderTrackShape(
///     waveOffset: _waveOffsetTween,
///     amplitudeFraction: _amplitudeFractionController,
///   );
///
///   @override
///   void initState() {
///     super.initState();
///     // wavelength / waveSpeed, matching how the progress indicator
///     // derives its own controller duration.
///     const wavelength = 40.0;
///     const waveSpeed = 40.0;
///     _waveOffsetController.duration = Duration(
///       milliseconds: ((wavelength / waveSpeed) * 1000).round(),
///     );
///   }
///
///   @override
///   void dispose() {
///     _waveOffsetController.dispose();
///     _amplitudeFractionController.dispose();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return SliderTheme(
///       data: SliderTheme.of(context).copyWith(trackShape: _trackShape),
///       child: Slider(value: widget.value, onChanged: widget.onChanged),
///     );
///   }
/// }
/// ```
class WavySliderTrackShape extends SliderTrackShape {
  WavySliderTrackShape({
    required this.waveOffset,
    this.amplitudeFraction = const AlwaysStoppedAnimation<double>(1),
    this.amplitude = 3,
    this.wavelength = 40,
    this.strokeWidth,
    this.trackGap = 6,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.disabledActiveTrackColor,
    this.disabledInactiveTrackColor,
  }) : assert(amplitude >= 0, 'amplitude must not be negative.'),
       assert(wavelength > 0, 'wavelength has to be greater than zero.'),
       assert(trackGap >= 0, 'trackGap must not be negative.'),
       assert(
         strokeWidth == null || strokeWidth > 0,
         'strokeWidth has to be greater than zero.',
       );

  /// The wave's current horizontal phase, in the range `[0, 1]`, where a
  /// full cycle equals one [wavelength]. Equivalent to
  /// `WavyLinearProgressIndicator`'s internal `_waveOffset`.
  ///
  /// Drive it with a repeating [AnimationController] whose duration is
  /// `wavelength / waveSpeed` seconds, restarted whenever `wavelength` or
  /// `waveSpeed` change, exactly like `_maybeUpdateAnimations` does in the
  /// progress indicator.
  final ValueListenable<double> waveOffset;

  /// How "deep" the wave currently is, in the range `[0, 1]`. `0` renders a
  /// flat line, `1` renders the full [amplitude]. Equivalent to
  /// `WavyLinearProgressIndicator`'s internal `_amplitudeFraction`.
  ///
  /// Defaults to an always-`1` listenable, i.e. a permanently wavy track.
  final ValueListenable<double> amplitudeFraction;

  /// The maximum amplitude of the wave.
  final double amplitude;

  /// The distance between two adjacent wave peaks.
  final double wavelength;

  /// The thickness of the drawn line.
  ///
  /// Defaults to `sliderTheme.trackHeight`.
  final double? strokeWidth;

  /// The gap left on either side of the thumb, between the thumb and the
  /// start of the active/inactive track segments. Conceptually the same
  /// idea as `WavyLinearProgressIndicator.trackGap`, just applied
  /// symmetrically around the thumb instead of only ahead of the value.
  final double trackGap;

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? disabledActiveTrackColor;
  final Color? disabledInactiveTrackColor;

  final _cache = _WavySliderPathCache();

  RenderBox? _listenedParentBox;
  VoidCallback? _repaintListener;

  /// Hooks a repaint request into [waveOffset]/[amplitudeFraction] so the
  /// slider repaints as the wave animates, without needing the [Slider]
  /// widget itself to rebuild every frame.
  void _ensureRepaintListenerAttached(RenderBox parentBox) {
    if (identical(_listenedParentBox, parentBox)) {
      return;
    }
    final oldListener = _repaintListener;
    if (oldListener != null) {
      waveOffset.removeListener(oldListener);
      amplitudeFraction.removeListener(oldListener);
    }
    _listenedParentBox = parentBox;
    void listener() {
      if (parentBox.attached) {
        parentBox.markNeedsPaint();
      }
    }

    _repaintListener = listener;
    waveOffset.addListener(listener);
    amplitudeFraction.addListener(listener);
  }

  @override
  bool get isRounded => true;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    assert(sliderTheme.trackHeight != null);
    final thumbWidth = sliderTheme.thumbShape!
        .getPreferredSize(isEnabled, isDiscrete)
        .width;
    final overlayWidth = sliderTheme.overlayShape!
        .getPreferredSize(isEnabled, isDiscrete)
        .width;
    final lineWidth = strokeWidth ?? sliderTheme.trackHeight!;
    // Reserve enough vertical room for the wave so it never gets clipped,
    // regardless of what trackHeight the theme specifies.
    final trackHeight = math.max(
      sliderTheme.trackHeight!,
      amplitude * 2 + lineWidth,
    );

    final trackLeft = offset.dx + math.max(overlayWidth / 2, thumbWidth / 2);
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackRight =
        trackLeft + parentBox.size.width - math.max(thumbWidth, overlayWidth);
    final trackBottom = trackTop + trackHeight;
    return Rect.fromLTRB(
      math.min(trackLeft, trackRight),
      trackTop,
      math.max(trackLeft, trackRight),
      trackBottom,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    TextDirection? textDirection,
    double additionalActiveTrackHeight = 2,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    _ensureRepaintListenerAttached(parentBox);

    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    if (trackRect.width <= 0) {
      return;
    }

    final lineWidth = strokeWidth ?? sliderTheme.trackHeight!;

    final activeColorTween = ColorTween(
      begin: disabledActiveTrackColor ?? sliderTheme.disabledActiveTrackColor,
      end: activeTrackColor ?? sliderTheme.activeTrackColor,
    );
    final inactiveColorTween = ColorTween(
      begin:
          disabledInactiveTrackColor ?? sliderTheme.disabledInactiveTrackColor,
      end: inactiveTrackColor ?? sliderTheme.inactiveTrackColor,
    );

    final activePaint = Paint()
      ..color = activeColorTween.evaluate(enableAnimation)!
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final inactivePaint = Paint()
      ..color = inactiveColorTween.evaluate(enableAnimation)!
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final isRTL = textDirection == TextDirection.rtl;
    var thumbFraction = ((thumbCenter.dx - trackRect.left) / trackRect.width)
        .clamp(0.0, 1.0);
    if (isRTL) {
      thumbFraction = 1 - thumbFraction;
    }

    _cache.update(
      width: trackRect.width,
      wavelength: wavelength,
      amplitude: amplitude,
      amplitudeFraction: amplitudeFraction.value,
      waveOffset: waveOffset.value,
      strokeWidth: lineWidth,
      trackGap: trackGap,
      thumbFraction: thumbFraction,
    );

    final canvas = context.canvas;
    canvas.save();
    // Move the origin to the vertical center of the track's left edge, so
    // all path math below can work in simple local coordinates the same
    // way `_WavyLinearProgressIndicatorPainter` does.
    canvas.translate(trackRect.left, trackRect.top + trackRect.height / 2);
    if (isRTL) {
      canvas.translate(trackRect.width, 0);
      canvas.scale(-1, 1);
    }

    // In LTR, "before the thumb" is the active (already-reached) side and
    // "after the thumb" is the inactive side. The RTL canvas flip above
    // keeps this mapping correct on screen without extra branching here.
    final beforeThumbPath = _cache.beforeThumbPath;
    if (beforeThumbPath != null) {
      canvas.drawPath(beforeThumbPath, activePaint);
    }
    final afterThumbPath = _cache.afterThumbPath;
    if (afterThumbPath != null) {
      canvas.drawPath(afterThumbPath, inactivePaint);
    }

    canvas.restore();
  }
}

/// Builds a full-length wave [Path] once per (width, wavelength, amplitude)
/// combination, then repeatedly cuts the active/inactive segments out of it
/// with [PathMetric.extractPath] — the same strategy
/// `_WavyLinearProgressIndicatorDrawingCache` uses, simplified for a single
/// determinate value (the thumb position) instead of progress fractions.
class _WavySliderPathCache {
  double _cachedWidth = -1;
  double _cachedWavelength = -1;
  double _cachedAmplitude = -1;

  Path _fullWavePath = Path();
  PathMetric? _pathMetric;
  double _pathScale = 1;

  double _cachedAmplitudeFraction = -1;
  double _cachedWaveOffset = -1;
  double _cachedStrokeWidth = -1;
  double _cachedTrackGap = -1;
  double _cachedThumbFraction = -1;

  /// The active segment, from the track's start up to just before the
  /// thumb (minus [trackGap]).
  Path? beforeThumbPath;

  /// The inactive segment, from just after the thumb (plus [trackGap]) to
  /// the track's end.
  Path? afterThumbPath;

  void update({
    required double width,
    required double wavelength,
    required double amplitude,
    required double amplitudeFraction,
    required double waveOffset,
    required double strokeWidth,
    required double trackGap,
    required double thumbFraction,
  }) {
    final needsFullRebuild =
        _cachedWidth != width ||
        _cachedWavelength != wavelength ||
        _cachedAmplitude != amplitude;

    if (needsFullRebuild) {
      _rebuildFullPath(
        width: width,
        wavelength: wavelength,
        amplitude: amplitude,
      );
    }

    if (!needsFullRebuild &&
        _cachedAmplitudeFraction == amplitudeFraction &&
        _cachedWaveOffset == waveOffset &&
        _cachedStrokeWidth == strokeWidth &&
        _cachedTrackGap == trackGap &&
        _cachedThumbFraction == thumbFraction) {
      // No update required.
      return;
    }

    _cachedAmplitudeFraction = amplitudeFraction;
    _cachedWaveOffset = waveOffset;
    _cachedStrokeWidth = strokeWidth;
    _cachedTrackGap = trackGap;
    _cachedThumbFraction = thumbFraction;

    final waveShift = waveOffset * wavelength;
    // Scaling happens about the local origin (y = 0), which is already the
    // wave's baseline here, so — unlike the progress indicator, which bakes
    // its baseline offset into the full path — no extra Y compensation is
    // needed when the amplitude fraction changes.
    final waveTransform = Matrix4.identity()
      ..translateByDouble(waveShift > 0 ? -waveShift : 0.0, 0.0, 0.0, 1.0)
      ..scaleByDouble(1.0, amplitudeFraction, 1.0, 1.0);

    final inset = strokeWidth / 2;
    final thumbX = thumbFraction * width;

    beforeThumbPath = null;
    afterThumbPath = null;

    final beforeTail = inset;
    final beforeHead = (thumbX - trackGap) - inset;
    if (beforeHead > beforeTail) {
      if (amplitudeFraction <= 0) {
        beforeThumbPath = Path()
          ..moveTo(beforeTail, 0)
          ..lineTo(beforeHead, 0);
      } else {
        final segment = _pathMetric!.extractPath(
          (beforeTail + waveShift) * _pathScale,
          (beforeHead + waveShift) * _pathScale,
        );
        beforeThumbPath = segment.transform(waveTransform.storage);
      }
    }

    final afterTail = (thumbX + trackGap) + inset;
    final afterHead = width - inset;
    if (afterHead > afterTail) {
      afterThumbPath = Path()
        ..moveTo(afterTail, 0)
        ..lineTo(afterHead, 0);
    }
  }

  void _rebuildFullPath({
    required double width,
    required double wavelength,
    required double amplitude,
  }) {
    final path = Path()..moveTo(0, 0);

    if (amplitude == 0) {
      path.lineTo(width + wavelength * 2, 0);
    } else {
      final halfWavelength = wavelength / 2;
      var anchorX = halfWavelength;
      const anchorY = 0.0;
      var controlX = halfWavelength / 2;
      // A quadratic Bezier with both anchors on y = 0 peaks at half of the
      // control point's offset, so controlY = amplitude * 2 yields peaks of
      // exactly `amplitude` above/below the baseline.
      var controlY = amplitude * 2;
      final widthWithExtraPhase = width + wavelength * 2;

      while (anchorX <= widthWithExtraPhase) {
        path.quadraticBezierTo(controlX, controlY, anchorX, anchorY);
        anchorX += halfWavelength;
        controlX += halfWavelength;
        controlY *= -1;
      }
    }

    _fullWavePath = path;
    _pathMetric = _fullWavePath.computeMetrics().first;
    final measuredLength = _pathMetric!.length;
    _pathScale =
        measuredLength /
        math.max(_fullWavePath.getBounds().width, double.minPositive);

    _cachedWidth = width;
    _cachedWavelength = wavelength;
    _cachedAmplitude = amplitude;

    // Invalidate the downstream cache so the draw paths get recomputed
    // against the freshly rebuilt full path.
    _cachedAmplitudeFraction = -1;
    _cachedWaveOffset = -1;
    _cachedStrokeWidth = -1;
    _cachedTrackGap = -1;
    _cachedThumbFraction = -1;
  }
}
