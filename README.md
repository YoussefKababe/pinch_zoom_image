# Pinch Zoom Image

A widget that makes picture pinch zoom, Instagram style!

![Example one](https://dl.dropboxusercontent.com/s/ke7ms7oys45r2ja/example1.jpg)
![Example two](https://dl.dropboxusercontent.com/s/ozo01jpv9xi5jqq/example2.jpg)

## Installation

Add this to your `pubspec.yml` dependencies:

```
pinch_zoom_image: "^0.2.5"
```

## How to use

Add the widget to your app like this (It automatically takes the size of the image you pass to it):

```dart
PinchZoomImage(
  image: Image.network('https://i.imgur.com/tKg0XEb.jpg'),
  zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
  hideStatusBarWhileZooming: true,
  onZoomStart: () {
    print('Zoom started');
  },
  onZoomEnd: () {
    print('Zoom finished');
  },
),
```

The `zoomedBackgroundColor` is the color that fills the image's space when the use is zooming it and moving it on the screen.

If you want images from internet to be cached for offline use or data saving, you can also use this with the [cached_network_image widget](https://pub.dartlang.org/packages/cached_network_image):

```dart
PinchZoomImage(
  image: CachedNetworkImage(
    imageUrl: 'https://i.imgur.com/tKg0XEb.jpg',
  ),
  zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
  hideStatusBarWhileZooming: true,
),
```

Enjoy!
