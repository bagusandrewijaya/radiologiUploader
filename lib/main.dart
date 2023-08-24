import 'package:flutter/material.dart';
import 'package:flutter_desktop_drag_drop/app/services/window_manger_service.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManagerService.setupWindow();
  runApp(const App());
}
