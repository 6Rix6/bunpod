import 'dart:async';

import 'package:bunpod/bunpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadEpisodeIdsCubit extends Cubit<ViewState<List<IdWithState>>> {
  DownloadEpisodeIdsCubit(this._repository)
    : super(ViewReady(_repository.getEpisodeIdsWithState())) {
    _subscribe();
  }

  final DownloadRepository _repository;

  StreamSubscription<List<IdWithState>>? _subscription;

  void _subscribe() {
    _subscription = _repository.episodeIdsWithStateStream().listen(
      (data) => emit(ViewReady(data)),
      onError: (error) => emit(state.copyWithPrevious(ViewFailed())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
