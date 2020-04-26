import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class MobileDataInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isNone = connectivityResult == ConnectivityResult.none;
    // final isWifi = connectivityResult == ConnectivityResult.wifi;
    // final isMobile = connectivityResult == ConnectivityResult.mobile;

    if (isNone) throw NoneConnectivityException();

    return request;
  }
}

class NoneConnectivityException implements Exception {
  final message = 'No Connectivity';

  @override
  String toString() => message;
}
