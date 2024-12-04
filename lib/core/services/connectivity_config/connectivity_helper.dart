import 'dart:async';
import 'dart:isolate';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:yash_practical/core/utility/utility.dart';
import 'package:yash_practical/main.dart';

class ConnectivityHelper {
  final StreamController<bool> streamController = StreamController<bool>();

  Future<bool> checkConnectivity({bool onlyCheckConnectivity = false}) async {
    try {
      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        if (onlyCheckConnectivity) {
          return true;
        } else {
          final bool isConnected = await pingUrl(
            networkPingUrl,
          );
          return isConnected;
        }
      } else {
        return false;
      }
    } catch (e) {
      Utility.showLog('Error in connectivity check : $e');
      return false;
    }
  }

  Stream<bool> checkConnectionStream({
    bool onlyCheckConnectivity = false,
  }) async* {
    bool isConnected = false;
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        if (onlyCheckConnectivity) {
          streamController.add(true);
        } else {
          isConnected = await pingUrl(
            networkPingUrl,
          );
          streamController.add(isConnected);
        }
      } else {
        isConnected = false;
        streamController.add(isConnected);
      }
    });

    yield* streamController.stream;
  }

  Future<bool> pingUrl(String pingUrl) async {
    final ReceivePort mainReceiverPort = ReceivePort();
    await Isolate.spawn(_postMainReceiveResult, <String, dynamic>{
      'sendPort': mainReceiverPort.sendPort,
      'pingUrl': pingUrl,
    });

    final SendPort argumentSenderPort =
        await mainReceiverPort.first as SendPort;

    final ReceivePort apiResponseReceiverPort = ReceivePort();

    argumentSenderPort.send(
      <String, dynamic>{
        'port': apiResponseReceiverPort.sendPort,
      },
    );

    final bool resultModel = await apiResponseReceiverPort.first as bool;
    return resultModel;
  }

  static Future<void> _postMainReceiveResult(
    Map<String, dynamic> message,
  ) async {
    final SendPort mainSenderPort = message['sendPort'] as SendPort;
    final String pingUrl = message['pingUrl'] as String;

    final ReceivePort argumentReceiverPort = ReceivePort();

    mainSenderPort.send(argumentReceiverPort.sendPort);

    final Map<String, dynamic> args =
        await argumentReceiverPort.first as Map<String, dynamic>;

    final SendPort apiResponseSenderPort = args['port'] as SendPort;
    bool result = false;
    try {
      final Response<dynamic> response = await Dio()
          .get(
            pingUrl,
          )
          .timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode! < 200 || response.statusCode! > 299) {
        result = false;
      }
      result = true;
    } catch (e) {
      Utility.showLog('Error in InternetCheck $e');
      result = false;
    }

    apiResponseSenderPort.send(result);
  }

  void disposeStream() {
    streamController.close();
  }
}
