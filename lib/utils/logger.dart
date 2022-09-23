import "package:logger/logger.dart";

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: false,
    printEmojis: false,
    printTime: false,
  ),
);

void info(
  String message, {
  Map<String, dynamic> data = const {},
}) async =>
    logger.i("$message: $data");

void warn(
  String message, {
  Map<String, dynamic> data = const {},
}) async =>
    logger.w("$message: $data");

void error(
  String message, {
  Map<String, dynamic> data = const {},
}) async =>
    logger.e("$message: $data");
