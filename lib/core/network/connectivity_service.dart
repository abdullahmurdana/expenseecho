import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:expenseecho/data/services/queue_manager.dart';

///[checkInternet] is used to fetch data from second isolate and send to main isolate.
bool checkInternet = true;

///[internetCheckingIsolate] is a second isolate to check internet without holding main isolate
Future internetCheckingIsolate() async {
  final ReceivePort otherReceivePort = ReceivePort();
  final isolate = await Isolate.spawn<SendPort>(
      connectivityTask, otherReceivePort.sendPort);
  otherReceivePort.listen((message) {
    if (message is bool) {
      checkInternet = message;
      if (!checkInternet) {
        isolate.kill(priority: Isolate.immediate);
      } else {
        QueueManager().syncPendingTransactions();
      }
    }
  });
}

///[connectivityTask] this function has a heavy task that fetch google and check the internet exist or not if yes then return true else return false
Future connectivityTask(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  Timer.periodic(const Duration(seconds: 2), (timer) async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        sendPort.send(true);
      } else {
        sendPort.send(false);
      }
    } catch (e) {
      sendPort.send(false);
    }
  });
}

class ConnectivityService {
  // this function check in every two minutes that internet is available or not
  ConnectivityService._();
  //this is a singleton
  static final ConnectivityService _instance = ConnectivityService._();
  static ConnectivityService get instance => _instance;

  Future checkConnection() async {
    await internetCheckingIsolate();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      try {
        if (!checkInternet) {
          // Get.toNamed('/noInternetScreen');
          checkInternet = true;
        }
      } on SocketException catch (_) {
        // Get.toNamed('/noInternetScreen');
        checkInternet = true;
      }
    });
  }

  Future checkConnectionForFirstTime() async {
    Timer(const Duration(seconds: 3), () async {
      try {
        final result = await InternetAddress.lookup('www.google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint('connected');
        }
        await checkConnection();
      } on SocketException catch (_) {
        // showErrorSnackBar(Lang.noInterNetConnection);
        // Get.toNamed('/noInternetScreen');
      }
    });
  }

  Future<bool> checkConnectionOnOnPress() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      }
      return false;
    } on SocketException catch (_) {
      // showErrorSnackBar(Lang.noInterNetConnection);
      return false;
    }
  }
}
