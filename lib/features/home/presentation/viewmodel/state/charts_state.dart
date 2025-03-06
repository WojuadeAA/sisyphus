import 'package:sisyphus/features/home/data/models/candle_ticker_model.dart';
import 'package:sisyphus/features/home/data/models/order_book_model.dart';
import 'package:sisyphus/features/home/data/models/symbol_model.dart';

class ChartState {
  final SymbolModel? symbol;
  final CandleTickerModel? candleTicker;
  final OrderBookModel? orderBook;
  ChartState({
    this.symbol,
    this.candleTicker,
    this.orderBook,
  });

  ChartState copyWith({
    SymbolModel? symbol,
    CandleTickerModel? candleTicker,
    OrderBookModel? orderBook,
  }) {
    return ChartState(
      symbol: symbol ?? this.symbol,
      candleTicker: candleTicker ?? this.candleTicker,
      orderBook: orderBook ?? this.orderBook,
    );
  }

  @override
  String toString() => 'ChartsState(symbol: $symbol, candleTicker: $candleTicker, orderBook: $orderBook)';

  @override
  bool operator ==(covariant ChartState other) {
    if (identical(this, other)) return true;

    return other.symbol == symbol && other.candleTicker == candleTicker && other.orderBook == orderBook;
  }

  @override
  int get hashCode => symbol.hashCode ^ candleTicker.hashCode ^ orderBook.hashCode;
}
