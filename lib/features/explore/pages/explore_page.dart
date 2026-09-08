import 'package:bunpod/bunpod.dart';
import 'package:bunpod/features/explore/widgets/category_card.dart';
import 'package:bunpod/features/explore/widgets/explore_item_pill.dart';
import 'package:bunpod/features/explore/widgets/explore_search_field.dart';
import 'package:bunpod/features/explore/widgets/host_bubble.dart';
import 'package:bunpod/features/explore/widgets/result_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ExplorePage());
  }

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _search = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  final SearchCubit _searchCubit = SearchCubit(locator());
  final ScrollController _scrollController = ScrollController();

  ExploreItem? _exploreItem;

  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    _searchFocus.dispose();
    _searchCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  String get _query => _search.text.trim();

  void _pickExploreItem(ExploreItem item) async {
    if (identical(_exploreItem, item)) {
      _clearExploreItem();
      return;
    }

    switch (item) {
      case ExploreCategory category:
        await _searchCubit.searchByCategory(category.name);
        break;
      case ExploreHost host:
        await _searchCubit.searchByHost(host.name);
        break;
    }

    if (!mounted) return;

    setState(() => _exploreItem = item);

    if (_query.isNotEmpty && identical(_exploreItem, item)) {
      _searchCubit.filter(_query);
    }

    await _scrollToTop();
  }

  void _clearExploreItem() {
    _search.clear();
    _searchCubit.clear();
    setState(() => _exploreItem = null);
  }

  void _clearSearch() {
    _search.clear();

    if (_exploreItem != null) {
      _searchCubit.filter('');
    } else {
      _searchCubit.clear();
    }

    setState(() {});
  }

  void _onQuerySubmitted(String value) {
    final String query = value.trim();

    if (_exploreItem != null) {
      _searchCubit.filter(query);
    } else {
      if (query.isEmpty) return;
      _searchCubit.search(query);
    }
  }

  void _openChannel(String feedUrl) {
    Navigator.of(context).push(ChannelPage.route(feedUrl));
  }

  Future<void> _scrollToTop() async {
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutExpo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchCubit,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: _AppBar(
          search: _search,
          searchFocus: _searchFocus,
          onQueryChanged: (_) {},
          onQuerySubmitted: _onQuerySubmitted,
          onClearSearch: _clearSearch,
        ),
        body: _Body(
          exploreItem: _exploreItem,
          onPickExploreItem: _pickExploreItem,
          onClearExploreItem: _clearExploreItem,
          onOpenChannel: _openChannel,
          scrollController: _scrollController,
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.search,
    required this.searchFocus,
    required this.onQueryChanged,
    required this.onQuerySubmitted,
    required this.onClearSearch,
  });

  final TextEditingController search;
  final FocusNode searchFocus;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onQuerySubmitted;
  final VoidCallback onClearSearch;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + _AppBarBottom.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const StyledBackButton(),
      title: const Text('Explore'),
      bottom: _AppBarBottom(
        search: search,
        searchFocus: searchFocus,
        onQueryChanged: (_) {},
        onQuerySubmitted: onQuerySubmitted,
        onClearSearch: onClearSearch,
      ),
    );
  }
}

class _AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarBottom({
    required this.search,
    required this.searchFocus,
    required this.onQueryChanged,
    required this.onQuerySubmitted,
    required this.onClearSearch,
  });

  final TextEditingController search;
  final FocusNode searchFocus;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onQuerySubmitted;
  final VoidCallback onClearSearch;

  static const EdgeInsets padding = EdgeInsets.fromLTRB(16, 0, 16, 8);
  static double get height => ExploreSearchField.height + padding.vertical;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: BlocSelector<SearchCubit, ViewState<List<SearchResultItem>>, bool>(
        selector: (state) => state is ViewBusy,
        builder: (context, value) => ExploreSearchField(
          controller: search,
          focusNode: searchFocus,
          onChanged: onQueryChanged,
          onSubmitted: onQuerySubmitted,
          onClearSearch: onClearSearch,
          isLoading: value,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.exploreItem,
    required this.onPickExploreItem,
    required this.onClearExploreItem,
    required this.onOpenChannel,
    required this.scrollController,
  });

  final ExploreItem? exploreItem;
  final ValueChanged<ExploreItem> onPickExploreItem;
  final VoidCallback onClearExploreItem;
  final ValueChanged<String> onOpenChannel;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      controller: scrollController,
      slivers: [
        if (exploreItem != null)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  ExploreItemPill(
                    item: exploreItem!,
                    onClear: onClearExploreItem,
                  ),
                ],
              ),
            ),
          ),
        BlocBuilder<SearchCubit, ViewState<List<SearchResultItem>>>(
          builder: (context, state) {
            final data = state.dataOrNull;

            if (data == null) {
              return SliverMainAxisGroup(slivers: _browseSlivers(context));
            }

            return SliverMainAxisGroup(
              slivers: _resultSlivers(context, data, onOpenChannel),
            );
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 24 + BottomPadding.of(context)),
        ),
      ],
    );
  }

  Widget _sectionLabel(BuildContext context, String label) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
      child: Text(
        label,
        style: tt.labelMedium?.copyWith(
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  List<Widget> _browseSlivers(BuildContext context) {
    return [
      SliverToBoxAdapter(child: _sectionLabel(context, 'HOSTS ON AIR')),
      SliverToBoxAdapter(
        child: BlocProvider<HostIdsCubit>(
          create: (_) => HostIdsCubit(
            locator(),
          ),
          child: BlocBuilder<HostIdsCubit, ViewState<List<int>>>(
            builder: (context, state) {
              final data = state.dataOrNull ?? [];
              final count = data.length;

              return SizedBox(
                height: 252,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.32,
                  ),
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return HostBubbleForId(
                      id: data[index],
                      onTap: onPickExploreItem,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      SliverToBoxAdapter(child: _sectionLabel(context, 'THE SHELVES')),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: BlocProvider(
          create: (_) => CategoryIdsCubit(locator()),
          child: BlocBuilder<CategoryIdsCubit, ViewState<List<int>>>(
            builder: (context, state) {
              final data = state.dataOrNull ?? [];
              final count = data.length;

              return SliverList.separated(
                itemCount: count,
                separatorBuilder: (_, _) => 4.gap,
                itemBuilder: (BuildContext context, int index) {
                  return CategoryCardForId(
                    id: data[index],
                    first: index == 0,
                    last: index == count - 1,
                    onTap: onPickExploreItem,
                  );
                },
              );
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> _resultSlivers(
    BuildContext context,
    List<SearchResultItem> results,
    ValueChanged<String> onOpenChannel,
  ) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    if (results.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 64, 24, 0),
            child: Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 40,
                  color: cs.outline,
                ),
                12.gap,
                Text(
                  'No shows match that — yet.',
                  style: tt.bodyLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12,
            childAspectRatio: 0.69,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = results[index];
              final Channel channel = item.channel;

              return ResultTile(
                channel: channel,
                onTap: () {
                  onOpenChannel(item.feedUrl);
                },
              );
            },
            childCount: results.length,
          ),
        ),
      ),
    ];
  }
}
