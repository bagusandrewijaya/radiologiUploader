import 'package:flutter/material.dart';
import 'package:flutter_desktop_drag_drop/app/utils/window_utils.dart';

class WindowButton extends StatelessWidget {
  final Color color;
  final Color hoverColor;
  final VoidCallback onTap;
  const WindowButton({Key key, this.color, @required this.hoverColor, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: Material(
        color: color ?? WindowUtils.defaultWindowButtonColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: InkWell(
          onTap: onTap,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: hoverColor,
        ),
      ),
    );
  }
}
