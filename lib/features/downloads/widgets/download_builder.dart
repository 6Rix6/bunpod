import 'package:bunpod/bunpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadBuilder extends StatelessWidget {
  const DownloadBuilder({
    super.key,
    required this.episode,
    required this.builder,
  });

  final Episode episode;
  final Widget Function(
    BuildContext context,
    DownloadState state,
    double? progress,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EpisodeDownloadProgressCubit>(
      create: (_) => EpisodeDownloadProgressCubit(locator(), episode: episode),
      child:
          BlocBuilder<EpisodeDownloadProgressCubit, ViewState<DownloadProgressInfo>>(
            builder: (context, state) {
              final info = state.dataOrNull ?? .initial();
              final progress = info.progress >= 0 ? info.progress : null;
              return builder(context, info.state, progress);
            },
          ),
    );
  }
}
