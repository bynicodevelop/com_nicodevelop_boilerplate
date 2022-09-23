import "package:another_flushbar/flushbar.dart";
import "package:flutter/material.dart";

Future<void> notification(
  BuildContext context,
  String title,
  String message,
  Color color,
  Color textColor,
) async =>
    Flushbar(
      title: title,
      titleColor: textColor,
      message: message,
      messageColor: textColor,
      backgroundColor: color,
      duration: const Duration(
        seconds: 2,
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.all(16.0),
      borderRadius: BorderRadius.circular(
        16.0,
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(.4),
          offset: const Offset(
            0.0,
            2.0,
          ),
          blurRadius: 5.0,
        ),
      ],
    ).show(context);

void sendNotificaton(
  BuildContext context,
  String title,
  String message,
) async =>
    notification(
      context,
      title,
      message,
      Colors.grey[100]!,
      Colors.black,
    );

void sendErrorNotification(
  BuildContext context,
  String message, {
  String title = "Error",
}) async =>
    notification(
      context,
      title,
      message,
      Colors.red,
      Colors.white,
    );

void sendSuccessNotification(
  BuildContext context,
  String message, {
  String title = "Success",
}) async =>
    notification(
      context,
      title,
      message,
      Colors.green,
      Colors.white,
    );
