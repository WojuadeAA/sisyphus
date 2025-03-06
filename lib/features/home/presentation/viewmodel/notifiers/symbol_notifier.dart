import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/features/home/data/home_repository.dart';
import 'package:sisyphus/features/home/data/models/symbol_model.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/chart_notifier.dart';

final symbolNotifierProvider = NotifierProvider<SymbolNotifier, List<SymbolModel>>(() {
  return SymbolNotifier();
});

class SymbolNotifier extends Notifier<List<SymbolModel>> {
  @override
  List<SymbolModel> build() {
    getSymbols();
    return [];
  }

  Future<void> getSymbols() async {
    final data = await ref.read(homeRepositoryProvider).getMarketSymbols();
    state = data.fold((l) => [], (r) {
      ref.read(chartsNotifierProvider.notifier).updateSymbol(r[11]);
      return r;
    });
  }
}
