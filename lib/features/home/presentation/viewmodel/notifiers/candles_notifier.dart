import 'dart:async';

import 'package:candlesticks/candlesticks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/features/home/data/home_repository.dart';
import 'package:sisyphus/features/home/data/models/stream_value_model.dart';

final candlesNotifierProvider = NotifierProvider<CandlesNotfier, List<Candle>>(() {
  return CandlesNotfier();
});

class CandlesNotfier extends Notifier<List<Candle>> {
  @override
  List<Candle> build() {
    return [];
  }

  Future<List<Candle>> getCandles(StreamValue streamValue) async {
    final data = await ref.read(homeRepositoryProvider).getCandles(
          symbol: streamValue.symbol.symbol!,
          interval: streamValue.interval!,
        );

    state = data.fold((l) => [], (r) => r);
    return state;
  }

  Future<void> loadMoreCandles(StreamValue streamValue) async {
    final data = await ref.read(homeRepositoryProvider).getCandles(
          symbol: streamValue.symbol.symbol!,
          interval: streamValue.interval!,
          endTime: state.last.date.millisecondsSinceEpoch,
        );

    state
      ..removeLast()
      ..addAll(data.fold(
        (l) => [],
        (r) => r,
      ));
  }

  void updateCandles(List<Candle> candles) {
    state = candles;
  }
}
