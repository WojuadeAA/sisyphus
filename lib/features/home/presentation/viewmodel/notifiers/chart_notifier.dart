import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sisyphus/features/home/data/models/candle_ticker_model.dart';
import 'package:sisyphus/features/home/data/models/order_book_model.dart';
import 'package:sisyphus/features/home/data/models/symbol_model.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/state/charts_state.dart';

final chartsNotifierProvider = NotifierProvider<ChartsNotifier, ChartState>(ChartsNotifier.new);

class ChartsNotifier extends Notifier<ChartState> {
  @override
  ChartState build() {
    return ChartState();
  }

  void updateSymbol(SymbolModel symbol) {
    state = state.copyWith(symbol: symbol);
  }

  void updateCandleTicker(CandleTickerModel candleTicker) {
    state = state.copyWith(candleTicker: candleTicker);
  }

  void updateOrderBook(OrderBookModel orderBook) {
    state = state.copyWith(orderBook: orderBook);
  }
}
