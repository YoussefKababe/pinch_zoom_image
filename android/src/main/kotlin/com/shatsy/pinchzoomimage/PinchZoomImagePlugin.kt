package com.shatsy.pinchzoomimage

import android.app.Activity
import android.view.View
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar

class PinchZoomImagePlugin(private val activity: Activity) : MethodCallHandler {
  private val originalSystemUiVisibility = activity.window?.decorView?.systemUiVisibility!!

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "pinch_zoom_image")
      channel.setMethodCallHandler(PinchZoomImagePlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when {
      call.method == "hideStatusBar" -> {
        activity.window?.decorView?.systemUiVisibility = originalSystemUiVisibility or
          View.SYSTEM_UI_FLAG_FULLSCREEN and
          View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN.inv() and
          View.SYSTEM_UI_FLAG_LAYOUT_STABLE.inv()
        result.success(null)
      }
      call.method == "showStatusBar" -> {
        activity.window?.decorView?.systemUiVisibility = originalSystemUiVisibility
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }
}
