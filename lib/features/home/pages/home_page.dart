import 'package:bunpod/bunpod.dart';
import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:expressive_refresh_indicator/expressive_refresh_indicator.dart';
import 'package:expressive_snack/expressive_snack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SliverItem {}

class HeaderItem extends SliverItem {
  final String label;
  final int count;
  final double topPadding;
  HeaderItem({
    required this.label,
    required this.count,
    required this.topPadding,
  });
}

class EpisodeItem extends SliverItem {
  final Episode episode;
  EpisodeItem(this.episode);
}

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
    with TickerProviderStateMixin {
  late List<FilterTab> _tabs;
  String? _channel;

  List<String?> get _tabValues => _tabs.map((tab) => tab.value).toList();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabs = _buildFilterTabs(context);
    _tabController = _createTabController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      logarte.attach(context: context, visible: kDebugMode);
    });
  }

  @override
  void dispose() {
    _tabController.animation?.removeListener(_syncChannelToTab);
    _tabController.dispose();
    super.dispose();
  }

  TabController _createTabController({int initialIndex = 0}) {
    final controller = TabController(
      length: _tabValues.length,
      vsync: this,
      initialIndex: initialIndex,
      animationDuration: const Duration(milliseconds: 220),
    );
    controller.animation!.addListener(_syncChannelToTab);
    return controller;
  }

  @override
  void didUpdateWidget(covariant HomePageLoaded oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_feedsEqual(oldWidget.feeds, widget.feeds)) {
      _rebuildTabs();
    }
  }

  bool _feedsEqual(List<PodcastFeed> a, List<PodcastFeed> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].channel.name != b[i].channel.name ||
          a[i].episodes.length != b[i].episodes.length) {
        return false;
      }
    }
    return true;
  }

  void _rebuildTabs() {
    final String? previousChannel = _channel;
    final List<FilterTab> newTabs = _buildFilterTabs(context);
    final List<String?> newValues = newTabs.map((t) => t.value).toList();

    int newIndex = newValues.indexOf(previousChannel);
    if (newIndex == -1) newIndex = 0;

    _tabController.animation?.removeListener(_syncChannelToTab);
    _tabController.dispose();

    setState(() {
      _tabs = newTabs;
      _tabController = _createTabController(initialIndex: newIndex);
      _channel = newValues[newIndex];
    });
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

      tabs.add(
        FilterTab(
          value: value,
          label: value,
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
    return RepaintBoundary(
      key: ValueKey('home_player'),
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) {
          if (state.episode == null) {
            return SizedBox.shrink();
          }

          final Episode current = state.episode!;

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
                    progress: state.progress,
                    timeLeft: state.remaining,
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
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _PinnedTabsDelegate(
        height: 64,
        child: Center(
          child: FilterTabs(
            tabs: _tabs,
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
        ? widget.feeds.expand((feed) => feed.episodes).toList()
        : widget.feeds
              .firstWhere(
                (feed) => feed.channel.name == channelName,
                orElse: () => widget.feeds.first,
              )
              .episodes;

    final List<SliverItem> items = [];
    bool first = true;

    for (final Bucket bucket in Bucket.values) {
      final List<Episode> eps = visible
          .where((e) => e.bucket == bucket)
          .toList();
      if (eps.isEmpty) continue;

      items.add(
        HeaderItem(
          label: _bucketLabels[bucket]!,
          count: eps.length,
          topPadding: first ? 16 : 32,
        ),
      );
      first = false;

      for (final Episode ep in eps) {
        items.add(EpisodeItem(ep));
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
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];

                if (item is HeaderItem) {
                  return SectionHeader(
                    label: item.label,
                    count: item.count,
                    topPadding: item.topPadding,
                  );
                }

                if (item is EpisodeItem) {
                  final ep = item.episode;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: BlocSelector<PlayerCubit, PlayerState, bool>(
                      selector: (state) => state.episode?.localId == ep.localId,
                      builder: (context, playing) => EpisodeCard(
                        episode: ep,
                        playing: playing,
                        onTap: () => _openPlayer(ep),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              childCount: items.length,
            ),
          ),
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
            SliverToBoxAdapter(
              child: _buildHomePlayer(),
            ),
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
