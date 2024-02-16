import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../presentation/shared/widgets/custom_toast.dart';

class ConnectivityService {
  static late ConnectivityResult _connectionStatus;
  static final Connectivity _connectivity = Connectivity();
  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static late FToast fToast;

  static void initConnectivity(BuildContext context) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    fToast = FToast();
    fToast.init(context);

    _checkInitialConnection();
  }

  static void dispose() {
    _connectivitySubscription.cancel();
    fToast.removeCustomToast();
  }

  static void _checkInitialConnection() async {
    try {
      _connectionStatus = await _connectivity.checkConnectivity();
      _updateConnectionStatus(_connectionStatus);
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status $e');
    }
  }

  static void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;

    if (_connectionStatus == ConnectivityResult.none) {
      _showNoInternetToast();
    } else {
      fToast.removeCustomToast();
    }
  }

  static void _showNoInternetToast() {
    fToast.showToast(
      child: const CustomToast(
        text: "Please check your internet connection.",
        textColor: Color.fromRGBO(255, 255, 255, 1),
        backgroundColor: Color.fromRGBO(190, 6, 6, 1),
      ),
      toastDuration: const Duration(hours: 2),
      gravity: ToastGravity.TOP,
    );
  }
}
