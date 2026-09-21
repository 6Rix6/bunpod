import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:motor/motor.dart';

enum ExpressiveMenuVariant { standard, vibrant }

class ExpressiveMenuItem {
  const ExpressiveMenuItem({
    required this.label,
    this.icon,
    this.trailing,
    this.selected = false,
    this.destructive = false,
    this.onPressed,
  });

  final String label;
  final IconData? icon;
  final String? trailing;
  final bool selected;
  final bool destructive;
  final VoidCallback? onPressed;
}

typedef ExpressiveMenuAnchorBuilder = Widget Function(
  BuildContext context,
  MenuController controller,
);

class ExpressiveMenu extends StatefulWidget {
  const ExpressiveMenu({
    super.key,
    required this.groups,
    required this.builder,
    this.variant = ExpressiveMenuVariant.standard,
    this.width = 240,
    this.offset = 4,
  });

  ExpressiveMenu.standard({
    super.key,
    required List<ExpressiveMenuItem> items,
    required this.builder,
    this.variant = ExpressiveMenuVariant.standard,
    this.width = 240,
    this.offset = 4,
  }) : groups = [items];

  final List<List<ExpressiveMenuItem>> groups;
  final ExpressiveMenuAnchorBuilder builder;
  final ExpressiveMenuVariant variant;
  final double width;

  /// Space between anchor and menu
  final double offset;

  @override
  State<ExpressiveMenu> createState() => _ExpressiveMenuState();
}

class _ExpressiveMenuState extends State<ExpressiveMenu> {
  final MenuController _controller = MenuController();

  final ValueNotifier<bool> _open = ValueNotifier<bool>(false);

  VoidCallback? _hideOverlay;

  @override
  void dispose() {
    _open.dispose();
    super.dispose();
  }

  void _onOpenRequested(Offset? position, VoidCallback showOverlay) {
    _hideOverlay = null;
    showOverlay();
    _open.value = true;
  }

  void _onCloseRequested(VoidCallback hideOverlay) {
    _hideOverlay = hideOverlay;
    _open.value = false;
  }

  void _onFxStatusChanged(AnimationStatus status) {
    if (_open.value) return;
    if (status != AnimationStatus.completed &&
        status != AnimationStatus.dismissed) {
      return;
    }
    final hide = _hideOverlay;
    _hideOverlay = null;
    hide?.call();
  }

  Widget _buildOverlay(BuildContext context, RawMenuOverlayInfo info) {
    final size = info.overlaySize;
    final anchor = info.anchorRect;

    final openUp = anchor.center.dy > size.height / 2;
    final alignEnd = anchor.center.dx > size.width / 2;
    final alignment = Alignment(alignEnd ? 1 : -1, openUp ? 1 : -1);

    final menuTheme = _MenuTheme.of(
      Theme.of(context).colorScheme,
      widget.variant,
    );

    return Positioned(
      left: alignEnd ? null : anchor.left,
      right: alignEnd ? size.width - anchor.right : null,
      top: openUp ? null : anchor.bottom + widget.offset,
      bottom: openUp ? size.height - anchor.top + widget.offset : null,
      child: TapRegion(
        groupId: info.tapRegionGroupId,
        onTapOutside: (_) => _controller.close(),
        child: Actions(
          actions: <Type, Action<Intent>>{
            DismissIntent: CallbackAction<DismissIntent>(
              onInvoke: (_) {
                _controller.close();
                return null;
              },
            ),
          },
          child: FocusScope(
            autofocus: true,
            child: FocusTraversalGroup(
              child: Material(
                type: MaterialType.transparency,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _open,
                  builder: (context, open, _) {
                    final target = open ? 1.0 : 0.0;
                    return SingleMotionBuilder(
                      motion: MaterialSpringMotion.expressiveEffectsDefault(),
                      from: 0,
                      value: target,
                      onAnimationStatusChanged: _onFxStatusChanged,
                      builder: (context, fx, _) {
                        return SingleMotionBuilder(
                          motion: MaterialSpringMotion.expressiveSpatialFast(),
                          from: 0,
                          value: target,
                          builder: (context, sp, _) {
                            return IgnorePointer(
                              ignoring: !open,
                              child: _MenuPanel(
                                groups: widget.groups,
                                menuTheme: menuTheme,
                                fx: fx,
                                sp: sp,
                                alignment: alignment,
                                width: widget.width,
                                onClose: _controller.close,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawMenuAnchor(
      controller: _controller,
      onOpenRequested: _onOpenRequested,
      onCloseRequested: _onCloseRequested,
      overlayBuilder: _buildOverlay,
      builder: (context, controller, child) =>
          widget.builder(context, controller),
    );
  }
}

class _MenuTheme {
  const _MenuTheme({
    required this.container,
    required this.onContainer,
    required this.icon,
    required this.selectedContainer,
    required this.onSelected,
    required this.error,
    required this.elevation,
  });

  final Color container;
  final Color onContainer;
  final Color icon;
  final Color selectedContainer;
  final Color onSelected;
  final Color error;
  final double elevation;

  factory _MenuTheme.of(ColorScheme cs, ExpressiveMenuVariant variant) {
    switch (variant) {
      case ExpressiveMenuVariant.standard:
        return _MenuTheme(
          container: cs.surfaceContainerLow,
          onContainer: cs.onSurface,
          icon: cs.onSurfaceVariant,
          selectedContainer: cs.tertiaryContainer,
          onSelected: cs.onTertiaryContainer,
          error: cs.error,
          elevation: 3
        );
      case ExpressiveMenuVariant.vibrant:
        return _MenuTheme(
          container: cs.tertiaryContainer,
          onContainer: cs.onTertiaryContainer,
          icon: cs.onTertiaryContainer,
          selectedContainer: cs.tertiary,
          onSelected: cs.onTertiary,
          error: cs.error,
          elevation: 0,
        );
    }
  }

  static const double panelOuterRadius = 20.0;
  static const double panelInnerRadius = 8.0;
  static const double panelGap = 2.0;
  static const double panelPadding = 4.0;

  static const double itemHeight = 48.0;
  static const double itemGap = 4.0;
  static const double itemHorizontalPadding = 12.0;
  static const double itemRadius = 4.0;
  static const double itemSelectedRadius = 16.0;
}

double _clamp(double v, double lo, double hi) => math.min(hi, math.max(lo, v));

class _MenuPanel extends StatelessWidget {
  const _MenuPanel({
    required this.groups,
    required this.menuTheme,
    required this.fx,
    required this.sp,
    required this.alignment,
    required this.width,
    required this.onClose,
  });

  final List<List<ExpressiveMenuItem>> groups;
  final _MenuTheme menuTheme;
  final double fx;
  final double sp;
  final Alignment alignment;
  final double width;
  final VoidCallback onClose;

  static const double _outer = _MenuTheme.panelOuterRadius;
  static const double _inner = _MenuTheme.panelInnerRadius;

  @override
  Widget build(BuildContext context) {
    var index = 0;
    final children = <Widget>[];

    for (var g = 0; g < groups.length; g++) {
      final isFirstGroup = g == 0;
      final isLastGroup = g == groups.length - 1;

      final tiles = <Widget>[];
      final group = groups[g];
      final length = group.length;

      for (var i = 0; i < length; i++) {
        final item = group[i];
        final d = index * 0.06;
        final a = _clamp((fx - d) / (1 - d), 0, 1);

        tiles.add(
          Opacity(
            opacity: a,
            child: _MenuItemTile(
              item: item,
              menuTheme: menuTheme,
              onClose: onClose,
              isFirst: isFirstGroup && i == 0,
              isLast: isLastGroup && i == length - 1,
            ),
          ),
        );
        index++;
      }

      children.add(
        Material(
          // decoration: BoxDecoration(
          color: menuTheme.container,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(isFirstGroup ? _outer : _inner),
            bottom: Radius.circular(isLastGroup ? _outer : _inner),
          ),
          elevation: menuTheme.elevation,
          child: Padding(
            padding: const EdgeInsets.all(_MenuTheme.panelPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: _MenuTheme.itemGap,
              children: tiles,
            ),
          ),
        ),
      );
      if (!isLastGroup) {
        children.add(const SizedBox(height: _MenuTheme.panelGap));
      }
    }

    return Opacity(
      opacity: _clamp(fx, 0, 1),
      child: Transform.scale(
        scaleX: math.max(0, 0.85 + 0.15 * sp),
        scaleY: math.max(0, 0.60 + 0.40 * sp),
        alignment: alignment,
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _MenuItemTile extends StatefulWidget {
  const _MenuItemTile({
    required this.item,
    required this.menuTheme,
    required this.onClose,
    this.isFirst = false,
    this.isLast = false,
  });

  final ExpressiveMenuItem item;
  final _MenuTheme menuTheme;
  final VoidCallback onClose;
  final bool isFirst;
  final bool isLast;

  @override
  State<_MenuItemTile> createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<_MenuItemTile> {
  bool _pressed = false;

  bool get _enabled => widget.item.onPressed != null;

  void _activate() {
    if (!_enabled) return;
    widget.item.onPressed?.call();
    widget.onClose();
  }

  Radius _getRadius(bool bottom, double r) {
    final bool edge = bottom ? widget.isLast : widget.isFirst;
    return Radius.circular(
      edge ? _MenuTheme.itemSelectedRadius : math.max(0, r),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final p = widget.menuTheme;
    final textTheme = Theme.of(context).textTheme;

    final Color fg = !_enabled
        ? p.onContainer.withValues(alpha: 0.38)
        : item.destructive
        ? p.error
        : item.selected
        ? p.onSelected
        : p.onContainer;
    final Color iconColor = !_enabled
        ? fg
        : item.destructive
        ? p.error
        : item.selected
        ? p.onSelected
        : p.icon;

    final baseRadius = item.selected
        ? _MenuTheme.itemSelectedRadius
        : _MenuTheme.itemRadius;
    final radius = _pressed ? _MenuTheme.itemSelectedRadius : baseRadius;

    return Semantics(
      button: true,
      enabled: _enabled,
      selected: item.selected,
      label: item.label,
      excludeSemantics: true,
      child: SingleMotionBuilder(
        motion: MaterialSpringMotion.expressiveSpatialFast(),
        value: radius,
        builder: (context, r, child) {
          final borderRadius = BorderRadius.vertical(
            top: _getRadius(false, r),
            bottom: _getRadius(true, r),
          );

          return Material(
            color: item.selected ? p.selectedContainer : Colors.transparent,
            borderRadius: borderRadius,
            clipBehavior: .hardEdge,
            child: InkWell(
              borderRadius: borderRadius,
              highlightColor: widget.menuTheme.onContainer.withValues(alpha: .08),
              splashColor: widget.menuTheme.onContainer.withValues(alpha: .08),
              onTapDown: _enabled
                  ? (_) => setState(() => _pressed = true)
                  : null,
              onTapUp: _enabled
                  ? (_) => setState(() => _pressed = false)
                  : null,
              onTapCancel: _enabled
                  ? () => setState(() => _pressed = false)
                  : null,
              onTap: _enabled ? _activate : null,
              child: child,
            ),
          );
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: _MenuTheme.itemHeight,
            maxHeight: _MenuTheme.itemHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _MenuTheme.itemHorizontalPadding,
            ),
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(item.icon, size: 20, color: iconColor),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge?.copyWith(
                      color: fg,
                      fontWeight: item.selected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (item.trailing != null) ...[
                  const SizedBox(width: 12),
                  Text(
                    item.trailing!,
                    style: textTheme.labelMedium?.copyWith(color: iconColor),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

