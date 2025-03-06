import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/constants/endpoints.dart';
import 'package:sisyphus/core/network/network_client.dart';
import 'package:sisyphus/core/network/response_processor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'models/symbol_model.dart';

final homeDataSourceProvider = Provider<HomeDataSource>((ref) => HomeDataSource(
      httpClient: ref.read(networkClientProvider),
    ));

class HomeDataSource {
  HomeDataSource({required this.httpClient});

  // HTTP Client
  final HttpClient httpClient;

  // WebSocket connections cache
  final Map<String, WebSocketChannel> _activeConnections = {};

  // HTTP Methods
  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    final response = await httpClient
        .get("${Endpoints.klines}?symbol=$symbol&interval=$interval${endTime != null ? '&endTime=$endTime' : ''}");
    return processResponse(response: response, serializer: (data) => _parseCandles(data));
  }

  Future<List<SymbolModel>> fetchSymbols() async {
    final response = await httpClient.get(Endpoints.symbols);
    return processResponse(response: response, serializer: (data) => _parseSymbols(data));
  }

  // WebSocket Management
  WebSocketChannel establishConnection(String symbol, String interval) {
    final key = '$symbol-$interval';
    if (_activeConnections.containsKey(key)) {
      return _activeConnections[key]!;
    }

    final channel = WebSocketChannel.connect(Uri.parse(Endpoints.wsUrl));

    channel.sink.add(jsonEncode({
      'method': 'SUBSCRIBE',
      'params': ['$symbol@kline_$interval', '$symbol@depth'],
      'id': 1
    }));

    _activeConnections[key] = channel;
    return channel;
  }

  void closeConnection(String symbol, String interval) {
    final key = '$symbol-$interval';
    _activeConnections[key]?.sink.close();
    _activeConnections.remove(key);
  }

  // Parsing Helpers
  List<Candle> _parseCandles(List<dynamic> data) {
    return data.map((e) => Candle.fromJson(e)).toList().reversed.toList();
  }

  List<SymbolModel> _parseSymbols(List<dynamic> data) {
    return data.map((e) => SymbolModel.fromJson(e)).toList();
  }
}
