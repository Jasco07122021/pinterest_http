import 'package:logger/logger.dart';
import 'package:pinterest_2022/services/dio_server.dart';

class LoggerPrint{
  static var logger = Logger();

  static void d(String message) {
    if (DioServer.isTester) logger.d(message);
  }

  static void i(String message) {
    if (DioServer.isTester) logger.i(message);
  }

  static void w(String message) {
    if (DioServer.isTester) logger.w(message);
  }

  static void e(String message) {
    if (DioServer.isTester) logger.e(message);
  }

}