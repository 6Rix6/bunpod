import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final database = AppDatabase();

  locator
    ..registerSingleton<AppDatabase>(database)
    ..registerSingleton<FeedDao>(database.feedDao)
    ..registerSingleton<SubscriptionDao>(database.subscriptionDao)
    ..registerSingleton<PlaybackDao>(database.playbackDao);

  locator.registerSingleton<ThemeModeCubit>(ThemeModeCubit());

  // audio_service requires init before runApp.
  final AudioHandlerService handler =
      await AudioHandlerService.initAudioService(
        'app.bunpod.channel.audio',
        'BunPod',
        androidNotificationIcon: 'drawable/ic_notification',
      );

  locator
    ..registerSingleton<AudioHandlerService>(handler)
    ..registerSingleton<PlayerCubit>(PlayerCubit(handler));

  locator
    ..registerSingleton<ItunesPodcastApi>(
      ItunesPodcastApi(),
      dispose: (instance) => instance.close(),
    )
    ..registerSingleton<RSSFeedClient>(
      RSSFeedClient(httpClient: Dio(RSSPodcastDataSourceImpl.baseOptions)),
      dispose: (instace) => instace.close(),
    );

  locator
    ..registerLazySingleton<RSSPodcastDataSource>(
      () => RSSPodcastDataSourceImpl(locator(), locator()),
    )
    ..registerLazySingleton<PodcastFeedRepository>(
      () => PodcastFeedRepositoryImpl(locator()),
      dispose: (instance) => instance.close(),
    )
    ..registerFactory<SubscribedFeedsCubit>(
      () => SubscribedFeedsCubit(locator()),
    );

  locator.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(locator()),
  );
}
