import 'package:bunpod/bunpod.dart';
import 'package:expressive_refresh_indicator/expressive_refresh_indicator.dart';
import 'package:expressive_snack/expressive_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SubscriptionsPage());
  }

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  void _openChannel(Channel channel) {
    Navigator.of(context).push(ChannelPage.route(channel.feedUrl));
  }

  void _onToggled(Channel channel, bool subscribed) {
    showExpressiveSnack(
      context: context,
      message: !subscribed
          ? 'Unsubscribed from ${channel.name}'
          : 'Resubscribed to ${channel.name}',
      icon: !subscribed ? Icons.close_rounded : Icons.add_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: BlocProvider<SubscribedChannelIdsCubit>(
        create: (_) => SubscribedChannelIdsCubit(locator()),
        child: Builder(
          builder: (context) => ExpressiveRefreshIndicator(
            onRefresh: () async {
              await context.read<SubscribedChannelIdsCubit>().refresh();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SubscribedChannelIdsCubit, ViewState<List<int>>>(
      builder: (context, state) => switch (state) {
        _ when state.dataOrNull != null && state.dataOrNull!.isNotEmpty =>
          ListView.separated(
            padding: .fromLTRB(
              16,
              8,
              16,
              32 + BottomPadding.of(context),
            ),
            itemCount: state.dataOrNull!.length,
            itemBuilder: (BuildContext context, int index) {
              final data = state.dataOrNull!;
              final id = data[index];

              return SubscriptionTileForId(
                channelId: id,
                borderRadius: _radiusFor(index, data.length),
                onTap: _openChannel,
                onToggled: _onToggled,
              );
            },
            separatorBuilder: (_, _) {
              return MenuSection.tileGap.gap;
            },
          ),
        _ => Center(
          // TODO: create no subscriptions screen
          child: Text('No subscriptions'),
        ),
      },
    );
  }

  BorderRadius _radiusFor(int index, int length) {
    const Radius outer = .circular(MenuSection.outerRadius);
    const Radius inner = .circular(MenuSection.innerRadius);

    return .vertical(
      top: index == 0 ? outer : inner,
      bottom: index == length - 1 ? outer : inner,
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const StyledBackButton(),
      title: const Text('Subscriptions'),
    );
  }
}
