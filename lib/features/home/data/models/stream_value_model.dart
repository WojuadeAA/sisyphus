import 'symbol_model.dart';

class StreamValue {
  StreamValue({
    required this.symbol,
    required this.interval,
  });
  late SymbolModel symbol;
  late String? interval;
}
