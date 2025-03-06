import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/features/home/data/models/stream_value_model.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/timeframe_selector.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/candles_notifier.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/chart_notifier.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/socket_notifier.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class Charts extends HookConsumerWidget {
  const Charts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTradingView = useState(true);
    final currentTime = useState('1H');
    final candles = ref.watch(candlesNotifierProvider);
    final currentSymbol = ref.watch(chartsNotifierProvider).symbol;
    final candlestick = ref.watch(chartsNotifierProvider).candleTicker;

    useEffect(() {
      if (currentSymbol != null) {
        ref
            .read(candlesNotifierProvider.notifier)
            .getCandles(
              StreamValue(
                symbol: currentSymbol,
                interval: currentTime.value.toLowerCase(),
              ),
            )
            .then((value) {
          ref.read(candlesNotifierProvider.notifier).updateCandles(value);
          if (candlestick == null) {
            ref.read(
              socketNotifier(
                StreamValue(
                  symbol: currentSymbol,
                  interval: currentTime.value.toLowerCase(),
                ),
              ),
            );
          }
        });
      }

      return null;
    }, [
      currentSymbol,
      currentTime.value,
    ]);

    return Column(
      children: [
        const SizedBox(height: 7),
        TimeframeSelector(
          onSelected: (value) {
            currentTime.value = value;
          },
        ),
        const SizedBox(height: 15),
        Divider(
          color: blackTint.withOpacity(.1),
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 9,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (!isTradingView.value) {
                    isTradingView.value = true;
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 13,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isTradingView.value
                        ? context.isDarkMode()
                            ? const Color(0xff555C63)
                            : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: SubText(
                      text: 'Trading view',
                      textSize: 14,
                      foreground: context.isDarkMode() ? white : blackTint2,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (isTradingView.value) {
                    isTradingView.value = false;
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 13,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: !isTradingView.value
                        ? context.isDarkMode()
                            ? const Color(0xff555C63)
                            : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: SubText(
                      text: 'Depth',
                      textSize: 14,
                      foreground: context.isDarkMode() ? white : blackTint2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SvgPicture.asset(
                ImageAssets.expand,
              )
            ],
          ),
        ),
        Divider(
          color: blackTint.withOpacity(.1),
          thickness: 1,
        ),
        if (candles.isNotEmpty)
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Candlesticks(
              key: Key(currentSymbol!.symbol! + currentTime.value),
              candles: candles,
              onLoadMoreCandles: () {
                return ref.read(candlesNotifierProvider.notifier).loadMoreCandles(
                      StreamValue(
                        symbol: currentSymbol,
                        interval: currentTime.value.toLowerCase(),
                      ),
                    );
              },
              actions: [
                ToolBarAction(
                  width: 45,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SvgPicture.asset(
                      ImageAssets.arrowDown,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                ToolBarAction(
                  width: 60,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: SubText(
                      text: currentSymbol.symbol!,
                      textSize: 11,
                      foreground: blackTint2,
                    ),
                  ),
                ),
                if (candlestick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          const SubText(
                            text: 'O ',
                            textSize: 11,
                            foreground: blackTint2,
                          ),
                          SubText(
                            text: candlestick.candle.open.formatAsRoundedInteger(),
                            textSize: 11,
                            foreground: textGreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (candlestick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          const SubText(
                            text: 'H ',
                            textSize: 11,
                            foreground: blackTint2,
                          ),
                          SubText(
                            text: candlestick.candle.high.formatAsRoundedInteger(),
                            textSize: 11,
                            foreground: textGreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (candlestick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          const SubText(
                            text: 'L ',
                            textSize: 11,
                            foreground: blackTint2,
                          ),
                          SubText(
                            text: candlestick.candle.low.formatAsRoundedInteger(),
                            textSize: 11,
                            foreground: textGreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (candlestick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          const SubText(
                            text: 'C ',
                            textSize: 11,
                            foreground: blackTint2,
                          ),
                          SubText(
                            text: candlestick.candle.close.formatAsRoundedInteger(),
                            textSize: 11,
                            foreground: textGreen,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
