import 'package:logger/logger.dart';

final appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 100,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.dateAndTime
  ),
);
