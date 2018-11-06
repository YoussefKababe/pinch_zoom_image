import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

class PinchZoomOverlayImage extends StatefulWidget {
  final Key key;
  final Offset origin;
  final double width;
  final double height;
  final Widget image;

  PinchZoomOverlayImage({
    this.key,
    @required this.origin,
    @required this.width,
    @required this.height,
    @required this.image,
  }) : super(key: key);

  @override
  PinchZoomOverlayImageState createState() => PinchZoomOverlayImageState();
}

class PinchZoomOverlayImageState extends State<PinchZoomOverlayImage>
    with TickerProviderStateMixin {
  AnimationController reverseAnimationController;
  Offset position;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    this.position = widget.origin;
  }

  @override
  void dispose() {
    reverseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: ((scale - 1.0) /
                  ((MediaQuery.of(context).size.height / widget.height) - 1.0))
              .clamp(0.0, 1.0),
          child: Container(
            color: Colors.black,
          ),
        ),
        Positioned(
          top: position.dy,
          left: position.dx,
          width: widget.width,
          height: widget.height,
          child: Transform.scale(
            scale: scale,
            child: widget.image,
          ),
        ),
      ],
    );
  }

  void updatePosition(Offset newPosition) {
    setState(() {
      position = newPosition;
    });
  }

  void updateScale(double newScale) {
    setState(() {
      scale = newScale;
    });
  }

  TickerFuture reverse() {
    Offset origin = widget.origin;
    Offset reverseStartPosition = position;
    double reverseStartScale = scale;

    reverseAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {
          position = Offset.lerp(
            reverseStartPosition,
            origin,
            Curves.easeInOut.transform(reverseAnimationController.value),
          );

          scale = lerpDouble(
            reverseStartScale,
            1.0,
            Curves.easeInOut.transform(reverseAnimationController.value),
          );
        });
      });

    return reverseAnimationController.forward(from: 0.0);
  }
}
