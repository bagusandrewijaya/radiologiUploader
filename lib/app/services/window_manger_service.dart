import 'package:flutter_desktop_drag_drop/app/utils/window_utils.dart';
import 'package:window_manager/window_manager.dart';

class WindowManagerService {
  //
  WindowManagerService._();

  static Future<void> setupWindow() async {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(
      WindowUtils.windowOptions,
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  static Future<void> maxUnMaxWindow() async {
    bool isMaximized = await windowManager.isMaximized();
    if (!isMaximized) {
      windowManager.maximize();
    } else {
      windowManager.unmaximize();
    }
  }

  static Future<void> closeWindow() async => await windowManager.close();
  static Future<void> minimizeWindow() async => await windowManager.minimize();
}
