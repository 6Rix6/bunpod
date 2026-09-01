import 'package:flutter/material.dart';
import 'snap_scroll_simulation.dart';

class SnapScrollPhysics extends ScrollPhysics {
  const SnapScrollPhysics(this.expandedHeight, {super.parent});

  final double expandedHeight;

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnapScrollPhysics(expandedHeight, parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if ((velocity.abs() < toleranceFor(position).velocity) ||
        (velocity > 0.0 && position.pixels >= position.maxScrollExtent) ||
        (velocity < 0.0 && position.pixels <= position.minScrollExtent)) {
      return null;
    }
    return SnapScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      expandedHeight: expandedHeight,
    );
  }
}
