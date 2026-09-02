import 'package:bunpod/bunpod.dart';
import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:expressive_refresh_indicator/expressive_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_shapes/material_shapes.dart';
import 'package:motor/motor.dart';

const double _kCoverSize = 168;
const double _kSubscribeHeight = 58;

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    super.key,
    required this.feedUrl,
    this.episodes,
    this.channel,
  });

  final String feedUrl;
  final List<Episode>? episodes;
  final Channel? channel;

  static Route<void> route(
    String feedUrl, {
    List<Episode>? episodes,
    Channel? channel,
  }) {
    return MaterialPageRoute<void>(
      builder: (context) =>
          ChannelPage(feedUrl: feedUrl, episodes: episodes, channel: channel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PodcastFeedCubit(locator(), url: feedUrl),
      // TODO: show snackbar when state is ViewFailed
      child: BlocBuilder<PodcastFeedCubit, ViewState<PodcastFeed>>(
        builder: (context, state) => switch (state) {
          _ when state.dataOrNull != null => _ChannelPageLoaded(
            feedUrl: feedUrl,
            episodes: state.dataOrNull!.episodes,
            channel: state.dataOrNull!.channel,
          ),
          ViewFailed(:final error) => _buildWrapper(
            context,
            Center(
              child: Text(error?.toString() ?? 'An error occurred.'),
            ),
          ),
          _ => _buildWrapper(
            context,
            Center(
              child: LoadingIndicator(),
            ),
          ),
        },
      ),
    );
  }

  Widget _buildWrapper(BuildContext context, Widget body) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    if (channel != null && episodes != null) {
      return _ChannelPageLoaded(
        feedUrl: feedUrl,
        episodes: episodes!,
        channel: channel!,
      );
    }

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(),
      body: body,
    );
  }
}

class _ChannelPageLoaded extends StatelessWidget {
  const _ChannelPageLoaded({
    required this.feedUrl,
    required this.episodes,
    required this.channel,
  });

  final String feedUrl;
  final List<Episode> episodes;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(
      context,
    ).copyWith(colorScheme: channel.scheme(context));
    final ColorScheme cs = theme.colorScheme;
    final TextTheme tt = theme.textTheme;

    // The header collapses from a full hero down to a plain back-button bar, so
    // measure the channel name to know exactly how tall the expanded state is.
    final double topPad = MediaQuery.paddingOf(context).top;
    final double maxW = MediaQuery.sizeOf(context).width - 48;
    final TextStyle hostStyle = (tt.labelMedium ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    );
    final TextPainter hostPainter = TextPainter(
      text: TextSpan(text: channel.host.toUpperCase(), style: hostStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: maxW);

    final TextStyle nameStyle = (tt.displaySmall ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w800,
      height: 1.05,
    );
    final TextPainter namePainter = TextPainter(
      text: TextSpan(text: channel.name, style: nameStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxW);

    final double minExtent = topPad + kToolbarHeight;
    // Exact expanded height: the hero column sized to its content, so the header
    // bottom lands flush under the subscribe button (the list adds its own gap).
    final double maxExtent =
        minExtent +
        8 + // back bar -> cover
        _kCoverSize +
        20 + // cover -> host
        hostPainter.height +
        8 + // host -> name
        namePainter.height +
        24 + // name -> subscribe
        _kSubscribeHeight;

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: cs.surface,
        body: ExpressiveRefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 3));
          },
          edgeOffset: topPad + kToolbarHeight,
          color: cs.onPrimaryContainer,
          backgroundColor: cs.primaryContainer,
          notificationPredicate: (notification) => notification.depth == 1,
          child: SnapScrollView(
            appBar: SnapAppBar(
              expandedHeight: maxExtent,
              actionsAlignment: .topRight,
              collapsedTitleAlignment: .topLeft,
              expandedTitle: _hero(context, cs, tt, topPad),
              collapsedTitle: Text(
                channel.name,
                style: tt.titleMedium?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: .ellipsis,
              ),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (channel.description.isNotEmpty) ...[
                        Text(
                          channel.description,
                          style: tt.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                        28.gap,
                      ],
                      Text(
                        'Episodes',
                        style: GoogleFonts.unbounded(
                          textStyle: tt.titleLarge,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                          color: cs.onSurface,
                        ),
                      ),
                      12.gap,
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final Episode ep = episodes[i];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                      child: BlocSelector<PlayerCubit, PlayerState, Episode?>(
                        selector: (state) => state.episode,
                        builder: (state, current) => EpisodeCard(
                          episode: ep,
                          playing: ep == current,
                          onTap: () => Navigator.of(
                            context,
                          ).push(PlayerPage.route(ep, fromChannel: true)),
                        ),
                      ),
                    );
                  },
                  childCount: episodes.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hero(
    BuildContext context,
    ColorScheme cs,
    TextTheme tt,
    double topPad,
  ) {
    return Column(
      children: [
        // Reserve the pinned bar's space so the cover sits below the back button.
        SizedBox(height: topPad + kToolbarHeight),
        8.gap,
        SingleMotionBuilder(
          motion: const MaterialSpringMotion.expressiveSpatialSlow(),
          value: 1.0,
          from: 0.0,
          builder: (context, t, child) {
            final double tc = t.clamp(0.0, 1.0);
            return Opacity(
              opacity: tc,
              child: Transform.scale(scale: 0.8 + 0.2 * t, child: child),
            );
          },
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: MaterialShapeBorder(shape: ShapeValues.cover),
            ),
            child: SizedBox(
              width: _kCoverSize,
              height: _kCoverSize,
              child: _Cover(channel: channel, scheme: cs),
            ),
          ),
        ),
        20.gap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            channel.host.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: tt.labelMedium?.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        8.gap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            channel.name,
            textAlign: TextAlign.center,
            style: tt.displaySmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
        ),
        24.gap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocProvider(
            create: (_) => SubscriptionCubit(locator(), feedUrl: feedUrl),
            child: BlocBuilder<SubscriptionCubit, ViewState<bool>>(
              builder: (context, state) => _SubscribeButton(
                subscribed: state.dataOrNull ?? false,
                scheme: cs,
                onTap: context.read<SubscriptionCubit>().toggle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.channel, required this.scheme});

  final Channel channel;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final Widget glyph = Icon(
      Icons.podcasts_rounded,
      color: scheme.onPrimaryContainer,
      size: 48,
    );
    return SmoothImage(
      url: channel.image,
      placeholderColor: scheme.primaryContainer,
      placeholderChild: glyph,
      errorChild: glyph,
    );
  }
}

/// Full-width expressive subscribe toggle. Not subscribed is the loud primary
/// call-to-action; subscribed settles into a calm tonal pill, and the corners
/// morph squarer as it flips. A spring drives the colour/shape, plus a
/// press-scale for tactility.
class _SubscribeButton extends StatefulWidget {
  const _SubscribeButton({
    required this.subscribed,
    required this.scheme,
    required this.onTap,
  });

  final bool subscribed;
  final ColorScheme scheme;
  final VoidCallback onTap;

  @override
  State<_SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<_SubscribeButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = widget.scheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: SingleMotionBuilder(
          motion: const MaterialSpringMotion.expressiveSpatialFast(),
          value: widget.subscribed ? 1.0 : 0.0,
          builder: (context, t, _) {
            final double tc = t.clamp(0.0, 1.0);
            final Color bg = Color.lerp(
              cs.primary,
              cs.surfaceContainerHigh,
              tc,
            )!;
            final Color fg = Color.lerp(cs.onPrimary, cs.onSurface, tc)!;
            final double radius = 30 - 12 * tc;
            return Container(
              height: _kSubscribeHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(radius < 0 ? 0 : radius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.subscribed ? Icons.check_rounded : Icons.add_rounded,
                    size: 22,
                    color: fg,
                  ),
                  10.gap,
                  Text(
                    widget.subscribed ? 'Subscribed' : 'Subscribe',
                    style: tt.titleMedium?.copyWith(
                      color: fg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
