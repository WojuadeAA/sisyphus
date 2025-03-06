import 'package:candlesticks/candlesticks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/runner/failure.dart';
import 'package:sisyphus/core/runner/service_runner.dart';
import 'package:sisyphus/features/home/data/home_datasource.dart';
import 'package:sisyphus/features/home/data/models/symbol_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref.read(homeDataSourceProvider));
});

class HomeRepository {
  final HomeDataSource _dataSource;

  HomeRepository(this._dataSource);

  // HTTP Operations
  FutureEither<List<Candle>> getCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) {
    return ServiceRunner<Failure, List<Candle>>().run(
      call: _dataSource.fetchCandles(
        symbol: symbol,
        interval: interval,
        endTime: endTime,
      ),
      name: 'getCandles',
    );
  }

  FutureEither<List<SymbolModel>> getMarketSymbols() {
    return ServiceRunner<Failure, List<SymbolModel>>().run(
      call: _dataSource.fetchSymbols(),
      name: 'getMarketSymbols',
    );
  }

  // Real-time Data Streams
  WebSocketChannel watchMarketData(String symbol, String interval) {
    final channel = _dataSource.establishConnection(symbol, interval);
    return channel;
  }

  void stopMarketData(String symbol, String interval) {
    _dataSource.closeConnection(symbol, interval);
  }
}
