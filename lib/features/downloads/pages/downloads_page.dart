import 'package:bunpod/bunpod.dart';
import 'package:expressive_snack/expressive_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const StyledBackButton(),
      title: const Text('Downloads'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DownloadEpisodeIdsCubit(locator()),
      child: BlocBuilder<DownloadEpisodeIdsCubit, ViewState<List<IdWithState>>>(
        builder: (context, state) {
          final List<IdWithState> data = state.dataOrNull ?? [];

          return _buildList(data, context);
        },
      ),
    );
  }

  Widget _buildList(List<IdWithState> data, BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final downloading = data.inProgress;
    final onDevice = data.completed;

    return ListView(
      padding: .fromLTRB(
        16,
        16,
        16,
        BottomPadding.of(context),
      ),
      children: [
        if (downloading.isNotEmpty) ...[
          DownloadSection(
            label: 'Downloading',
            children: downloading
                .mapWithIndex(
                  (task, index) =>
                      _episodeTile(task.id, index, downloading.length),
                )
                .toList(),
          ),
          32.gap,
        ],
        if (onDevice.isNotEmpty) ...[
          DownloadSection(
            label: 'On device',
            children: onDevice
                .mapWithIndex(
                  (task, index) =>
                      _episodeTile(task.id, index, onDevice.length),
                )
                .toList(),
          ),
        ],
        24.gap,
        Center(
          child: TextButton.icon(
            onPressed: () {
              ComingSoon.show(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: cs.onSurfaceVariant,
              textStyle: tt.labelMedium,
            ),
            icon: const Icon(Icons.auto_delete_outlined, size: 18),
            label: const Text('Auto-delete played episodes: after 30 days'),
          ),
        ),
      ],
    );
  }

  Widget _episodeTile(int id, int index, int itemCount) {
    return BlocProvider(
      key: ValueKey('episode$id'),
      create: (_) => EpisodeCubit(locator(), id: id),
      child: _EpisodeView(index: index, itemCount: itemCount),
    );
  }
}

class _EpisodeView extends StatelessWidget {
  const _EpisodeView({required this.index, required this.itemCount});

  final int index;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final episode = context.watch<EpisodeCubit>().state.dataOrNull;
    if (episode == null) return const SizedBox.shrink();

    return BlocProvider(
      create: (_) => EpisodeDownloadProgressCubit(locator(), episode: episode),
      child: _DownloadView(
        episode: episode,
        index: index,
        itemCount: itemCount,
      ),
    );
  }
}

class _DownloadView extends StatefulWidget {
  const _DownloadView({
    required this.episode,
    required this.index,
    required this.itemCount,
  });

  final Episode episode;
  final int index;
  final int itemCount;

  @override
  State<_DownloadView> createState() => _DownloadViewState();
}

class _DownloadViewState extends State<_DownloadView> {
  bool _removing = false;

  Episode get _episode => widget.episode;
  EpisodeDownloadProgressCubit get _cubit =>
      context.read<EpisodeDownloadProgressCubit>();

  void _onTap() {
    Navigator.of(context).push(PlayerPage.route(_episode));
  }

  Future<void> _onCancel(DownloadState state) async {
    if (state.isSuccessful) return;

    if (state.isInProgress) {
      final cubit = _cubit;
      setState(() => _removing = true);

      await cubit.cancel();
      return;
    }

    if (state.isUnsuccessful) {
      setState(() => _removing = true);
    }
  }

  Future<void> _onRetry(DownloadState state) async {
    if (!state.isUnsuccessful) return;
    await _cubit.retry();
  }

  Future<void> _onDelete() async {
    final cubit = _cubit;
    final file = await cubit.getFile();

    if (file == null) return;

    final int length = await file.length();
    final int megabytes = length ~/ (1024 * 1024);
    final String size = sizeLabel(megabytes);

    if (!mounted) return;

    final bool confirmed = await StyledSheet.show(
      context,
      icon: Icons.delete_outline_rounded,
      title: 'Remove download?',
      message:
          'Removes "${_episode.title}" from this device and frees '
          '$size. You can download it again anytime.',
      confirmLabel: 'Free up $size',
      destructive: true,
    );

    if (!confirmed || !mounted) return;

    await cubit.deleteFile(deleteTask: false);

    if (!mounted) return;

    setState(() {
      _removing = true;
    });

    showExpressiveSnack(
      context: context,
      message: '$size freed',
      icon: Icons.delete_outline_rounded,
    );
  }

  Future<void> _onRemoved() async {
    await _cubit.deleteTask();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      EpisodeDownloadProgressCubit,
      ViewState<DownloadProgressInfo>
    >(
      builder: (context, state) {
        final info = state.dataOrNull;
        if (info == null) return const SizedBox.shrink();

        return DownloadTile(
          episode: _episode,
          download: info,
          borderRadius: DownloadSection.radiusFor(
            widget.index,
            widget.itemCount,
          ),
          onTap: info.state.isSuccessful ? _onTap : null,
          onDelete: _onDelete,
          onRemoved: _onRemoved,
          onCancel: () => _onCancel(info.state),
          onRetry: () => _onRetry(info.state),
          removing: _removing,
        );
      },
      listener: (context, state) {
        if (state is ViewFailed) {
          showExpressiveSnack(context: context, message: 'Error!');
        }
      },
    );
  }
}
