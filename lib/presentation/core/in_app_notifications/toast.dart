import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AppToast extends StatelessWidget {
  final String message;
  final NotificationPosition position;
  final Duration? duration;
  final Widget? leading;
  final EdgeInsetsGeometry? margin;
  final Color background;
  final Color textColor;
  final bool autoDismiss;

  const AppToast({
    required this.message,
    this.background = Colors.black,
    this.textColor = Colors.black,
    this.position = NotificationPosition.top,
    this.autoDismiss = true,
    this.duration,
    this.leading,
    this.margin,
    super.key,
  });

  factory AppToast.success(String message) {
    return AppToast(
      background: Colors.greenAccent,
      duration: const Duration(seconds: 3),
      message: message,
    );
  }

  factory AppToast.error(String message) {
    return AppToast(
      background: Colors.redAccent,
      duration: const Duration(seconds: 3),
      message: message,
    );
  }

  void show() {
    showOverlayNotification(
      (context) => this,
      position: position,
      duration: duration,
    );
  }

  OverlaySupportEntry showInfo() {
    return showSimpleNotification(
      this,
      background: Colors.transparent,
      autoDismiss: autoDismiss,
      position: position,
      contentPadding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24).add(
              margin ?? EdgeInsets.zero,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: leading == null ? TextAlign.center : null,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
