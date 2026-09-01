import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bunpod/bunpod.dart';

const double _kExpendedAppBarHeightRatio = 3 / 8;

class SnapScrollView extends StatefulWidget {
  const SnapScrollView({
    super.key,
    this.globalKey,
    required this.appBar,
    this.slivers = const [],
  });

  /// The globalKey that is used to get innerScrollController
  /// of [NestedScrollViewState].
  final GlobalKey<NestedScrollViewState>? globalKey;

  final SnapAppBar appBar;
  final List<Widget> slivers;

  @override
  State<SnapScrollView> createState() => _SnapScrollViewState();
}

class _SnapScrollViewState extends State<SnapScrollView>
    with SingleTickerProviderStateMixin {
  late final GlobalKey<NestedScrollViewState> _nestedScrollViewStateKey;
  late double _calculatedExpandedHeight;

  final ValueNotifier<double> _appBarHeightNotifier = ValueNotifier(0);
  final ScrollController _scrollController = ScrollController();

  double? _savedOuterOffset;
  bool _isCollapsed = false;
  bool _hasRestoredOrInitialized = false;
  bool _isSnapping = false;

  SnapAppBar get _appBar => widget.appBar;

  @override
  void initState() {
    super.initState();
    _nestedScrollViewStateKey =
        widget.globalKey ?? GlobalKey<NestedScrollViewState>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initOuterControllerListener();
    });
  }

  @override
  void dispose() {
    _appBarHeightNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasRestoredOrInitialized) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _restoreOuterOffset();
    });
  }

  void _initOuterControllerListener() {
    final state = _nestedScrollViewStateKey.currentState;
    if (state == null) return;

    final outerController = state.outerController;
    final topPadding = MediaQuery.of(context).padding.top;

    _appBarHeightNotifier.value = _calculatedExpandedHeight + topPadding;

    outerController.addListener(() {
      _isCollapsed =
          outerController.offset >=
          (_calculatedExpandedHeight - _appBar.toolbarHeight);

      final currentHeight =
          _calculatedExpandedHeight - outerController.offset + topPadding;

      _appBarHeightNotifier.value = currentHeight.clamp(
        _appBar.toolbarHeight + topPadding,
        double.infinity,
      );

      _savedOuterOffset = outerController.offset;
    });

    if (_savedOuterOffset != null) {
      _restoreOuterOffset();
    } else if (_appBar.initiallyCollapsed) {
      final maxOffset = _calculatedExpandedHeight - _appBar.toolbarHeight;
      outerController.jumpTo(maxOffset);
      _isCollapsed = true;
    }
    _hasRestoredOrInitialized = true;
  }

  void _restoreOuterOffset() {
    final savedOffset = _savedOuterOffset;
    if (savedOffset == null) return;

    final state = _nestedScrollViewStateKey.currentState;
    if (state == null) return;

    final outerController = state.outerController;
    if (!outerController.hasClients) return;

    final maxOffset = _calculatedExpandedHeight - _appBar.toolbarHeight;
    final clampedOffset = savedOffset.clamp(0.0, maxOffset);
    final targetOffset = _isCollapsed ? maxOffset : clampedOffset;

    if ((outerController.offset - targetOffset).abs() > 1.0) {
      outerController.jumpTo(targetOffset);
    }
  }

  void _snapAppBar(ScrollController controller, double snapOffset) async {
    if (_isSnapping) return;
    _isSnapping = true;

    try {
      await controller.animateTo(
        snapOffset,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 150),
      );
    } catch (_) {
    } finally {
      _isSnapping = false;
    }
  }

  bool _onScrollEndNotification(ScrollEndNotification notification) {
    if (_isSnapping) return false;

    final scrollViewState = _nestedScrollViewStateKey.currentState;
    if (scrollViewState == null) return false;

    final outerController = scrollViewState.outerController;
    final innerController = scrollViewState.innerController;

    // Check if inner scroll is at top and outer is not at edge
    if (innerController.position.pixels == 0 &&
        !outerController.position.atEdge) {
      final range = _calculatedExpandedHeight - _appBar.toolbarHeight;
      final snapOffset = (outerController.offset / range) > 0.5 ? range : 0.0;

      Future.microtask(() => _snapAppBar(outerController, snapOffset));
    }

    return false;
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    final topPadding = MediaQuery.of(context).padding.top;

    var expandRatio =
        (constraints.maxHeight - _appBar.toolbarHeight - topPadding) /
        (_calculatedExpandedHeight - _appBar.toolbarHeight);

    return expandRatio.clamp(0.0, double.infinity);
  }

  Widget _expandedTitle(Animation<double> animation, double expandRatio) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
        ),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
          ),
        ),
        child: Center(
          child:
              _appBar.expandedTitleBuilder?.call(expandRatio) ??
              _appBar.expandedTitle,
        ),
      ),
    );
  }

  Widget _collapsedTitle(
    BuildContext context,
    Animation<double> animation,
    Widget? leading,
  ) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Align(
        alignment: _appBar.collapsedTitleAlignment,
        child: SizedBox(
          height: _appBar.toolbarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                SizedBox(width: kToolbarHeight, child: leading),
                SizedBox(width: NavigationToolbar.kMiddleSpacing),
              ],
              Expanded(
                child: FadeTransition(
                  opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DefaultTextStyle(
                      style: tt.titleLarge!,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      child: _appBar.collapsedTitle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    final actions = _appBar.actions;
    if (actions == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Align(
        alignment: _appBar.actionsAlignment,
        child: Container(
          padding: EdgeInsets.only(right: _appBar.actionSpacing),
          height: _appBar.toolbarHeight,
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _headerSliverBuilder(
    BuildContext context,
    bool innerBoxIsScrolled,
  ) {
    Widget? leading = _appBar.leading;
    if (leading == null && _appBar.automaticallyImplyLeading) {
      leading = ModalRoute.of(context)?.canPop == true
          ? StyledBackButton(color: Theme.of(context).colorScheme.onSurface)
          : null;
    }

    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          expandedHeight: _calculatedExpandedHeight,
          toolbarHeight: _appBar.toolbarHeight,
          elevation: _appBar.elevation,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final expandRatio = _calculateExpandRatio(constraints);
              final animation = AlwaysStoppedAnimation<double>(
                expandRatio.clamp(0.0, 1.0),
              );

              return Stack(
                fit: StackFit.expand,
                alignment: .center,
                children: [
                  Center(
                    child: OverflowBox(
                      maxHeight: _calculatedExpandedHeight,
                      child: _expandedTitle(animation, expandRatio),
                    ),
                  ),
                  _collapsedTitle(context, animation, leading),
                  _actions(context),
                  Align(
                    alignment: .bottomCenter,
                    child: _appBar.bottomDivider,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _calculatedExpandedHeight =
        _appBar.expandedHeight ??
        (MediaQuery.of(context).size.height * _kExpendedAppBarHeightRatio);

    return NotificationListener<ScrollEndNotification>(
      onNotification: _onScrollEndNotification,
      child: NestedScrollView(
        key: _nestedScrollViewStateKey,
        controller: _scrollController,
        physics: SnapScrollPhysics(_calculatedExpandedHeight),
        scrollBehavior: const CupertinoScrollBehavior(),
        headerSliverBuilder: _headerSliverBuilder,
        body: Builder(
          builder: (context) => CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverMainAxisGroup(slivers: widget.slivers),
            ],
          ),
        ),
      ),
    );
  }
}

class SnapAppBar {
  const SnapAppBar({
    required this.collapsedTitle,
    this.expandedTitle,
    this.expandedTitleBuilder,
    this.leading,
    this.actions,
    this.actionSpacing = 0.0,
    this.bottomDivider,
    this.expandedHeight,
    this.toolbarHeight = kToolbarHeight,
    this.elevation = 0.0,
    this.initiallyCollapsed = false,
    this.automaticallyImplyLeading = true,
    this.stretchCurve = Curves.easeOut,
    this.collapsedTitleAlignment = Alignment.bottomLeft,
    this.actionsAlignment = Alignment.bottomRight,
  });

  final Widget collapsedTitle;
  final Widget? expandedTitle;
  final Widget Function(double expandRatio)? expandedTitleBuilder;
  final Widget? leading;
  final List<Widget>? actions;
  final double actionSpacing;
  final Divider? bottomDivider;
  final double? expandedHeight;
  final double toolbarHeight;
  final double elevation;
  final bool initiallyCollapsed;
  final bool automaticallyImplyLeading;
  final Curve stretchCurve;
  final AlignmentGeometry collapsedTitleAlignment;
  final AlignmentGeometry actionsAlignment;
}
