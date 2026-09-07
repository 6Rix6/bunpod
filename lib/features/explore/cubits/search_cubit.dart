import 'package:bunpod/bunpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<ViewState<List<SearchResultItem>>> {
  SearchCubit(this._repository) : super(const ViewIdle());

  final SearchRepository _repository;

  final List<SearchResultItem> _searchResult = [];

  void clear() {
    _searchResult.clear();
    emit(const ViewIdle());
  }

  Future<void> search(String query) async {
    await _searchBy(query, (q) => _repository.search(q));
  }

  Future<void> searchByCategory(String query) async {
    await _searchBy(query, (q) => _repository.searchByCategory(q));
  }

  Future<void> searchByHost(String query) async {
    await _searchBy(query, (q) => _repository.searchByHost(q));
  }

  Future<void> _searchBy(
    String query,
    AppTaskEither<List<SearchResultItem>> Function(String q) func,
  ) async {
    final q = query.trim().toLowerCase();

    if (state.isBusy || q.isEmpty) return;
    emit(state.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(func(q));

    if (!isClosed) {
      _searchResult.clear();
      _searchResult.addAll(nextState.dataOrNull ?? const []);

      emit(state.copyWithPrevious(nextState));
    }
  }

  void filter(String query) {
    final data = _searchResult;
    if (data.isEmpty) return;

    final String q = query.trim().toLowerCase();

    if (q.isEmpty) {
      emit(state.copyWithPrevious(ViewReady(data)));
      return;
    }

    final result = <SearchResultItem>[
      for (final SearchResultItem item in data)
        if (_isMatch(item.channel, q)) item,
    ];

    emit(state.copyWithPrevious(ViewReady(result)));
  }

  bool _isMatch(Channel channel, String query) =>
      channel.name.toLowerCase().contains(query) ||
      channel.host.toLowerCase().contains(query);
}
