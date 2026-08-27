import 'package:bunpod/bunpod.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<ThemeModeCubit>(ThemeModeCubit());

  // audio_service requires init before runApp.
  final AudioHandlerService handler = await AudioHandlerService
      .initAudioService('app.bunpod.playback', 'BunPod playback');
  locator.registerSingleton<AudioHandlerService>(handler);
  locator.registerSingleton<PlayerCubit>(PlayerCubit(handler));
}
