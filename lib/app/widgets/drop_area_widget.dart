import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_drag_drop/app/utils/image_utils.dart';
import 'package:flutter_desktop_drag_drop/app/widgets/simple_fade_widget.dart';

class DropAreaWidget extends StatefulWidget {
  final void Function(List<XFile> files) onFiles;
  const DropAreaWidget({Key key, @required this.onFiles}) : super(key: key);

  @override
  State<DropAreaWidget> createState() => _DropAreaWidgetState();
}

class _DropAreaWidgetState extends State<DropAreaWidget> {
  //
  bool dragging = false;
  Offset localPosition = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DropTarget(
            onDragEntered: (details) {
              dragging = true;
              localPosition = details.localPosition;
              setState(() {});
            },
            onDragUpdated: (details) {
              localPosition = details.localPosition;
              setState(() {});
            },
            onDragExited: (details) {
              dragging = false;
              localPosition = details.localPosition;
              setState(() {});
            },
            onDragDone: (details) {
              final files = details.files.where(
                (element) =>
                    ImageUtils.checkMimeType(element.path) !=
                    ImageMimeType.other,
              );
              widget.onFiles(files.toList());
              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: dragging ? Colors.grey : Colors.white10,
                border: Border.all(
                  color:Color(0xff2e4786),
                  width: dragging ? 4 : 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.file_copy_sharp, size: 96,color: Colors.grey,),
                  const SizedBox(height: 8),
                  Text('Drop Files Disini',
                      style: TextStyle(
                        color:Colors.black
                      )),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: localPosition.dx - 28,
          top: localPosition.dy - 28,
          child: SizedBox(
            width: 56,
            height: 56,
            child: IgnorePointer(
              ignoring: true,
              child: SimpleFadeWidget(
                reverse: dragging,
                child: Image.asset('images/picture.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
