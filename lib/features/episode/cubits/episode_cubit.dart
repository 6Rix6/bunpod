import 'package:bunpod/bunpod.dart';

class EpisodeCubit extends ViewCubit<Episode> {
  EpisodeCubit(this._repository, {required int id}) : _id = id {
    _refresh();
  }

  final int _id;
  final EpisodeRepository _repository;

  Future<void> _refresh() async {
    if (state.isBusy || isClosed) return;
    emit(state.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(_repository.getEpisodeForId(_id));

    if (!isClosed) {
      emit(state.copyWithPrevious(nextState));
    }
  }

  @override
  String get id => '$runtimeType $_id';

  @override
  Object? toJsonT(Episode data) => data.toJson();

  @override
  Episode fromJsonT(Object? json) =>
      Episode.fromJson(json as Map<String, dynamic>);
}
