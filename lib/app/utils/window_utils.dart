import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowUtils {
  //
  static const WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(900, 600),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  static const Color defaultWindowButtonColor = Colors.white60;
}
