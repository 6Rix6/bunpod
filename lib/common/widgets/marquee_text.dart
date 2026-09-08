import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:motor/motor.dart';

class MarqueeText extends StatefulWidget {
  const MarqueeText({
    super.key,
    required this.text,
    required this.style,
    required this.playing,
  });

  final String text;
  final TextStyle? style;
  final bool playing;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  static const Duration _marqueeCycle = Duration(seconds: 20);

  static const double _speed = 45;
  static const double _minTravel = 1.4;
  static const double _maxTravel = 6.0;
  static const double _holdStart = 2.0;
  static const double _holdEnd = 1.5;
  static const double _fadePx = 22;

  static final SpringSimulation _spring = ScrollSpringSimulation(
    const MaterialSpringMotion.standardSpatialSlow().description,
    0,
    1,
    0,
  );
  static final double _settle = _settleTime();

  static double _settleTime() {
    double t = 0;
    while (!_spring.isDone(t) && t < 4) {
      t += 1 / 240;
    }
    return t;
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _marqueeCycle,
  );

  TextPainter? _tp;

  void _layout() {
    _tp?.dispose();
    _tp = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: 1,
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
  }

  @override
  void initState() {
    super.initState();
    if (widget.playing) _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _layout();
  }

  @override
  void didUpdateWidget(covariant MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text || widget.style != oldWidget.style) {
      _layout();
    }

    if (widget.playing && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.playing && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _tp?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String text = widget.text;
    final TextStyle? style = widget.style;
    final bool playing = widget.playing;
    final TextPainter tp = _tp!;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double marqueeTime =
            _controller.value * _marqueeCycle.inMilliseconds / 1000;

        return LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;
            final double overflow = tp.width - maxWidth;

            if (overflow <= 0.5) {
              return Text(
                text,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.clip,
                style: style,
              );
            }

            final double offset = playing
                ? _offset(overflow, marqueeTime)
                : 0;
            final double frac = (_fadePx / maxWidth).clamp(0.0, 0.45);
            final double leftFade = (offset / _fadePx).clamp(0.0, 1.0);
            final double rightFade = ((overflow - offset) / _fadePx).clamp(
              0.0,
              1.0,
            );

            final Widget scrolling = SizedBox(
              width: maxWidth,
              height: tp.height,
              child: ClipRect(
                child: OverflowBox(
                  maxWidth: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(-offset, 0),
                    child: Text(
                      text,
                      maxLines: 1,
                      softWrap: false,
                      style: style,
                    ),
                  ),
                ),
              ),
            );

            return ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(0, 0, 0, 1 - leftFade),
                  const Color(0xFF000000),
                  const Color(0xFF000000),
                  Color.fromRGBO(0, 0, 0, 1 - rightFade),
                ],
                stops: [0.0, frac, 1 - frac, 1.0],
              ).createShader(bounds),
              child: scrolling,
            );
          },
        );
      },
    );
  }

  double _offset(double overflow, double t) {
    final double travel = (overflow / _speed).clamp(_minTravel, _maxTravel);
    if (t < _holdStart) return 0;
    if (t < _holdStart + travel) {
      return _curve((t - _holdStart) / travel) * overflow;
    }
    if (t < _holdStart + travel + _holdEnd) return overflow;
    if (t < _holdStart + 2 * travel + _holdEnd) {
      final double p = (t - _holdStart - travel - _holdEnd) / travel;
      return (1 - _curve(p)) * overflow;
    }
    return 0;
  }

  double _curve(double p) => _spring.x(p * _settle).clamp(0.0, 1.0);
}
