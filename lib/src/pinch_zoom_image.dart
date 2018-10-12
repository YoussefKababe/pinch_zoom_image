import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinch_zoom_image/src/pinch_zoom_overlay_image.dart';

class PinchZoomImage extends StatefulWidget {
  final Widget image;
  final Color zoomedBackgroundColor;
  final bool hideStatusBarWhileZooming;
  final Function onZoomStart;
  final Function onZoomEnd;

  PinchZoomImage({
    @required this.image,
    this.zoomedBackgroundColor = Colors.transparent,
    this.hideStatusBarWhileZooming = false,
    this.onZoomStart,
    this.onZoomEnd,
  });

  @override
  _PinchZoomImageState createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage> {
  static const channel = const MethodChannel('pinch_zoom_image');
  OverlayEntry overlayEntry;
  Offset scaleStartPosition;
  Offset origin;
  int numPointers = 0;
  bool zooming = false;
  bool reversing = false;
  GlobalKey<PinchZoomOverlayImageState> overlayKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => numPointers++,
      onPointerUp: (_) => numPointers--,
      child: GestureDetector(
        onScaleStart: _handleScaleStart,
        onScaleUpdate: _handleScaleUpdate,
        onScaleEnd: _handleScaleEnd,
        child: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Opacity(
              opacity: zooming ? 0.0 : 1.0,
              child: widget.image,
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                color:
                    zooming ? widget.zoomedBackgroundColor : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    if (overlayEntry != null || reversing || numPointers < 2) return;
    setState(() {
      zooming = true;
    });
    if (widget.hideStatusBarWhileZooming) channel.invokeMethod('hideStatusBar');
    if (widget.onZoomStart != null) widget.onZoomStart();
    OverlayState overlayState = Overlay.of(context);
    double width = context.size.width;
    double height = context.size.height;
    origin = (context.findRenderObject() as RenderBox)
        .localToGlobal(Offset(0.0, 0.0));
    scaleStartPosition = details.focalPoint;

    overlayEntry = OverlayEntry(
      maintainState: true,
      builder: (BuildContext context) {
        return PinchZoomOverlayImage(
          key: overlayKey,
          height: height,
          width: width,
          origin: origin,
          image: widget.image,
        );
      },
    );

    overlayState.insert(overlayEntry);
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (reversing || numPointers < 2) return;
    overlayKey?.currentState
        ?.updatePosition(origin - (scaleStartPosition - details.focalPoint));
    if (details.scale >= 1.0)
      overlayKey?.currentState?.updateScale(details.scale);
  }

  void _handleScaleEnd(ScaleEndDetails details) async {
    if (reversing || !zooming) return;
    reversing = true;
    if (widget.hideStatusBarWhileZooming) channel.invokeMethod('showStatusBar');
    if (widget.onZoomEnd != null) widget.onZoomEnd();
    await overlayKey?.currentState?.reverse();
    overlayEntry?.remove();
    overlayEntry = null;
    origin = null;
    scaleStartPosition = null;
    reversing = false;
    setState(() {
      zooming = false;
    });
  }
}
