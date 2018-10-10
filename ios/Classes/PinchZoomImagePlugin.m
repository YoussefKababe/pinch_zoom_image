#import "PinchZoomImagePlugin.h"
#import <pinch_zoom_image/pinch_zoom_image-Swift.h>

@implementation PinchZoomImagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPinchZoomImagePlugin registerWithRegistrar:registrar];
}
@end
