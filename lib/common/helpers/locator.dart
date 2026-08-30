import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
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
    ..registerSingleton<PlayerCubit>(PlayerCubit(handler))
    ..registerSingleton<ItunesPodcastApi>(
      ItunesPodcastApi(),
      dispose: (instance) => instance.close(),
    )
    ..registerLazySingleton<RSSPodcastDataSource>(
      () => RSSPodcastDataSourceImpl(),
      dispose: (instance) => instance.close(),
    )
    ..registerLazySingleton<PodcastFeedRepository>(
      () => PodcastFeedRepositoryImpl(locator()),
      dispose: (instance) => instance.close(),
    )
    ..registerFactory<PodcastFeedsCubit>(() => PodcastFeedsCubit(locator()));
}
