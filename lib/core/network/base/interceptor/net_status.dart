import 'dart:io';

abstract class NetStatus {
  ///200 或 0
  static const int ok = HttpStatus.ok;

  static const int error = 99999;

  static const int loginError = 1075;
}
