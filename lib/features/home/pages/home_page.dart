import 'package:bunpod/bunpod.dart';
import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:expressive_refresh_indicator/expressive_refresh_indicator.dart';
import 'package:expressive_snack/expressive_snack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: const HomeAppBar(),
      body: BlocBuilder<SubscribedFeedsCubit, ViewState<List<PodcastFeed>>>(
        builder: (context, state) => switch (state) {
          _ when state.dataOrNull != null => HomePageLoaded(
            feeds: state.dataOrNull!,
          ),
          ViewFailed(:final error) => Center(
            child: Text(error?.toString() ?? 'An error occurred.'),
          ),
          _ => Center(
            child: LoadingIndicator(),
          ),
        },
      ),
    );
  }
}

class HomePageLoaded extends StatefulWidget {
  const HomePageLoaded({super.key, required this.feeds});

  final List<PodcastFeed> feeds;

  @override
  State<HomePageLoaded> createState() => _HomePageLoadedState();
}

class _HomePageLoadedState extends State<HomePageLoaded>
    with SingleTickerProviderStateMixin {
  late final List<FilterTab> tabs = _buildFilterTabs(context);
  String? _channel;

  List<String?> get _tabValues => tabs.map((tab) => tab.value).toList();

  late final TabController _tabController = TabController(
    length: _tabValues.length,
    vsync: this,
    animationDuration: const Duration(milliseconds: 220),
  );

  @override
  void initState() {
    super.initState();
    _tabController.animation!.addListener(_syncChannelToTab);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      logarte.attach(context: context, visible: kDebugMode);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _syncChannelToTab() {
    final String? value = _tabValues[_tabController.animation!.value.round()];
    if (value != _channel) setState(() => _channel = value);
  }

  List<FilterTab> _buildFilterTabs(BuildContext context) {
    final List<FilterTab> tabs = <FilterTab>[
      FilterTab(
        value: null,
        label: 'All',
        icon: Icons.grid_view_rounded,
      ),
    ];

    for (final feed in widget.feeds) {
      final Channel channel = feed.channel;

      final String value = channel.name;
      final String label = value.length > 10
          ? '${value.substring(0, 10)}...'
          : value;

      tabs.add(
        FilterTab(
          value: value,
          label: label,
          seed: channel.seed,
          image: channel.image,
          shape: ShapeValues.coverFocused,
        ),
      );
    }

    return tabs;
  }

  Future<void> _refresh() async {
    await context.read<SubscribedFeedsCubit>().refresh(
      onError: (error) =>
          showExpressiveSnack(context: context, message: error.toString()),
    );
  }

  void _openPlayer(Episode episode) {
    Navigator.of(context).push(PlayerPage.route(episode));
  }

  PodcastFeed? _feedForChannelName(String name) {
    try {
      return widget.feeds.firstWhere((f) => f.channel.name == name);
    } catch (_) {
      return null;
    }
  }

  Widget _buildHomePlayer() {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) {
        if (state.episode == null) {
          return SizedBox.shrink();
        }

        final bool live = state.duration > Duration.zero;
        final Episode current = state.episode!;

        final double progress = live ? state.progress : current.progress;

        final Duration timeLeft = live
            ? state.remaining
            : current.total - current.listened;

        return Column(
          children: [
            24.gap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () => _openPlayer(current),
                child: HomePlayerCard(
                  scheme: current.scheme(context),
                  imageUrl: current.image,
                  channel: current.channel,
                  title: current.title,
                  progress: progress,
                  timeLeft: timeLeft,
                  playing: state.playing,
                  coverShape: ShapeValues.coverFocused,
                  onPlayPause: () => context.read<PlayerCubit>().toggle(),
                ),
              ),
            ),
            32.gap,
          ],
        );
      },
    );
  }

  Widget _buildTabs(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _PinnedTabsDelegate(
        height: 64,
        child: Center(
          child: FilterTabs(
            tabs: tabs,
            selected: _channel,
            onSelected: (value) {
              // Tapping the already-selected channel a second time
              // opens its channel page (the "All" tab is exempt).
              if (value != null && value == _channel) {
                final PodcastFeed? feed = _feedForChannelName(value);

                if (feed != null) {
                  Navigator.of(
                    context,
                  ).push(
                    ChannelPage.route(
                      feed.url,
                      channel: feed.channel,
                      episodes: feed.episodes,
                    ),
                  );
                }
                return;
              }
              final int i = _tabValues.indexOf(value);
              if (i != -1) _tabController.animateTo(i);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, String? channelName) {
    final List<Episode> visible = channelName == null
        ? widget.feeds
              .map((feed) => feed.episodes)
              .expand((eps) => eps)
              .toList()
        : widget.feeds
              .firstWhere((feed) => feed.channel.name == channelName)
              .episodes;

    final List<Widget> children = <Widget>[];
    bool first = true;
    for (final Bucket bucket in Bucket.values) {
      final List<Episode> eps = visible
          .where((e) => e.bucket == bucket)
          .toList();
      if (eps.isEmpty) continue;
      children.add(
        SectionHeader(
          label: _bucketLabels[bucket]!,
          count: eps.length,
          topPadding: first ? 16 : 32,
        ),
      );
      first = false;
      for (final Episode ep in eps) {
        children.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: BlocSelector<PlayerCubit, PlayerState, Episode?>(
              selector: (state) => state.episode,
              builder: (context, current) => EpisodeCard(
                episode: ep,
                playing: ep == current,
                onTap: () => _openPlayer(ep),
              ),
            ),
          ),
        );
      }
    }

    return CustomScrollView(
      key: PageStorageKey(channelName ?? '__all__'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 32),
          sliver: SliverList(delegate: SliverChildListDelegate(children)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpressiveRefreshIndicator(
      onRefresh: _refresh,
      // Inside NestedScrollView the drag comes from the inner scrollables
      // (outer -> TabBarView page -> list = depth 2), so the default
      // depth-0 predicate would never trigger.
      notificationPredicate: (notification) => notification.depth == 2,
      child: NestedScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        headerSliverBuilder: (context, innerScrolled) {
          return [
            SliverToBoxAdapter(child: _buildHomePlayer()),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                context,
              ),
              sliver: _buildTabs(context),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          physics: const SpringPagePhysics(),
          children: [
            for (final value in _tabValues)
              Builder(builder: (context) => _buildPage(context, value)),
          ],
        ),
      ),
    );
  }
}

const _bucketLabels = <Bucket, String>{
  Bucket.today: 'Today',
  Bucket.yesterday: 'Yesterday',
  Bucket.thisWeek: 'This Week',
  Bucket.thisMonth: 'This Month',
  Bucket.earlier: 'Earlier',
};

class _PinnedTabsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _PinnedTabsDelegate({
    required this.child,
    required this.height,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _PinnedTabsDelegate old) {
    return old.child != child || old.height != height;
  }
}
