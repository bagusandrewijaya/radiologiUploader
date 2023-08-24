import 'package:flutter/material.dart';
import 'package:flutter_desktop_drag_drop/app/services/window_manger_service.dart';
import 'package:flutter_desktop_drag_drop/app/widgets/window_button.dart';
import 'package:window_manager/window_manager.dart';

class ToolbarWidget extends StatelessWidget {
  final String title;
  const ToolbarWidget({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      color: Color(0xff2e4786),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) => windowManager.startDragging(),
              onDoubleTap: () => WindowManagerService.maxUnMaxWindow(),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(title),
              ),
            ),
          ),
          // minimize button
          WindowButton(
            hoverColor: Colors.amber,
            onTap: () => WindowManagerService.minimizeWindow(),
          ),
          const SizedBox(width: 4),
          // restore button
          WindowButton(
            color: Colors.green,
            hoverColor: Colors.orange,
            onTap: () => WindowManagerService.maxUnMaxWindow(),
          ),
          const SizedBox(width: 4),
          // close button
          WindowButton(
            color: Colors.redAccent,
            hoverColor: Colors.red,
            onTap: () => WindowManagerService.closeWindow(),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
