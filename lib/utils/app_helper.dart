import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nft/utils/app_extension.dart';

class AppHelper {
  /// Show bottom sheet scrollable
  /// final bool res = await AppHelper.showBottomSheet(context,
  //         (_, ScrollController scrollController) {
  //       return WSheet(scrollController: scrollController);
  //     });
  static Future<T> showBottomSheet<T>(
      BuildContext context,
      Widget Function(BuildContext context, ScrollController scrollController)
          child) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        return DraggableScrollableSheet(
            // padding from top of screen on load
            initialChildSize: 1 - 85 / size.height,
            // full screen on scroll
            maxChildSize: 1,
            minChildSize: 0.25,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.W),
                    topRight: Radius.circular(30.W),
                  ),
                  child: child(context, scrollController));
            });
      },
    );
  }

  /// Show popup
  static Future<T> showPopup<T>(
    BuildContext context,
    Widget Function(BuildContext context) builder, {
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// Show snack bar
  static void showFlushBar(BuildContext context, String message) {
    Flushbar<void>(
            message: message,
            duration: const Duration(milliseconds: 2000),
            flushbarStyle: FlushbarStyle.GROUNDED)
        .show(context);
  }

  /// Show toast
  static void showToast(
    String msg, {
    Toast toastLength,
    int timeInSecForIosWeb,
    Color backgroundColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength ?? Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: timeInSecForIosWeb ?? 1,
        backgroundColor: backgroundColor ?? Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  /// blocks rotation; sets orientation to: portrait
  static Future<void> portraitModeOnly() {
    return SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  /// blocks rotation; sets orientation to: landscape
  static Future<void> landscapeModeOnly() {
    return SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
  }

  /// Enable rotation
  static Future<void> enableRotation() {
    return SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
  }

  /// Change next focus
  static void nextFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
