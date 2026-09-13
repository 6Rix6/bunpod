import 'dart:async';
import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SubscribedChannelIdsCubit extends ViewCubit<List<int>> {
  SubscribedChannelIdsCubit(this._repository) {
    refresh();
  }

  final SubscribedChannelsRepository _repository;

  Future<void> refresh() async {
    final prevState = state;
    if (prevState.isBusy || isClosed) return;

    emit(prevState.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(
      _repository.getSubscribedChannelIds(),
    );

    if (!isClosed) {
      emit(prevState.copyWithPrevious(nextState));
    }
  }

  @override
  List<int> toJsonT(List<int> data) => data;

  @override
  List<int> fromJsonT(Object? json) => (json as List).cast<int>();
}

class SubscriptionCubit extends StreamViewCubit<bool> {
  SubscriptionCubit(
    this._repository, {
    required String feedUrl,
  }) : _feedUrl = feedUrl;

  final SubscriptionRepository _repository;
  final String _feedUrl;

  @override
  String get id => '$runtimeType $_feedUrl';

  @override
  Stream<bool> watchStream() => _repository.watchIsSubscribed(_feedUrl);

  Future<void> subscribe() async {
    await _repository
        .subscribe(_feedUrl)
        .match(
          (error) => emit(state.copyWithPrevious(ViewFailed(error))),
          (_) {},
        )
        .run();
  }

  Future<void> unsubscribe() async {
    await _repository
        .unsubscribe(_feedUrl)
        .match(
          (error) => emit(state.copyWithPrevious(ViewFailed(error))),
          (_) {},
        )
        .run();
  }

  Future<void> toggle() async {
    final current = state;
    if (current.isBusy) return;

    final isSubscribed = current.dataOrNull == true;

    if (isSubscribed) {
      await unsubscribe();
    } else {
      await subscribe();
    }
  }

  @override
  Object? toJsonT(bool data) => data;

  @override
  bool fromJsonT(Object? json) => json as bool;
}

class ChannelCubit extends HydratedCubit<ViewState<Channel>> {
  ChannelCubit(this._repository, {required int channelId})
    : _id = channelId,
      super(const ViewIdle()) {
    refresh();
  }

  final ChannelsRepository _repository;
  final int _id;

  Future<void> refresh() async {
    final previousState = state;
    if (previousState.isBusy || isClosed) return;
    emit(previousState.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(_repository.getChannelById(_id));

    if (!isClosed) {
      emit(previousState.copyWithPrevious(nextState));
    }
  }

  @override
  String get id => '$runtimeType $_id';

  @override
  Map<String, dynamic>? toJson(ViewState<Channel> state) =>
      state.toJson((channel) => channel.toJson());

  @override
  ViewState<Channel>? fromJson(Map<String, dynamic> json) =>
      ViewState<Channel>.fromJsonSafe(
        json,
        (raw) => Channel.fromJson(raw as Map<String, dynamic>),
      );
}
