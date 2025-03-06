import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/chart_notifier.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class SummaryCardWidget extends ConsumerWidget {
  const SummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSymbol = ref.watch(chartsNotifierProvider).symbol;

    final candlestick = ref.watch(chartsNotifierProvider).candleTicker;
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).shadowColor,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.btcUsdPair,
                  width: 44,
                  height: 24,
                ),
                const SizedBox(width: 8),
                if (currentSymbol != null) ...[
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SubText(
                          text: currentSymbol.symbol!,
                          textSize: 18,
                        ),
                        const SizedBox(width: 10),
                        const Padding(
                          padding: EdgeInsets.all(2),
                          child: Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 27),
                  SubText(
                    text: '\$${double.tryParse(currentSymbol.price!).formatAsRoundedInteger()}',
                    textSize: 18,
                    foreground: textGreen,
                  ),
                ] else ...[
                  const SubText(
                    text: '--',
                    textSize: 18,
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ),
                  const SizedBox(width: 27),
                  const SubText(
                    text: r'$0.0',
                    textSize: 18,
                    foreground: textGreen,
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 18,
                              color: blackTint,
                            ),
                            SizedBox(width: 5),
                            SubText(
                              text: '24h change',
                              textSize: 12,
                              foreground: blackTint,
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        if (candlestick != null)
                          SubText(
                            text: '${candlestick.candle.volume.formatWithTwoDecimalPlaces()} +1%',
                            textSize: 14,
                            foreground: textGreen,
                          )
                        else
                          const SubText(
                            text: '0.00 +0.00%',
                            textSize: 14,
                            foreground: textGreen,
                          )
                      ],
                    ),
                  ),
                  const SizedBox(width: 17),
                  Container(
                    width: 1,
                    height: 48,
                    color: divider.withOpacity(.08),
                  ),
                  const SizedBox(width: 17),
                  SizedBox(
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              size: 18,
                              color: blackTint,
                            ),
                            SizedBox(width: 5),
                            SubText(
                              text: '24h high',
                              textSize: 12,
                              foreground: blackTint,
                            )
                          ],
                        ),
                        const SizedBox(width: 5),
                        if (candlestick != null)
                          SubText(
                            text: '${candlestick.candle.high.formatAsRoundedInteger()} +1%',
                            textSize: 14,
                          )
                        else
                          const SubText(
                            text: '0.00 +0.00%',
                            textSize: 14,
                          )
                      ],
                    ),
                  ),
                  const SizedBox(width: 17),
                  Container(
                    width: 1,
                    height: 48,
                    color: divider.withOpacity(.08),
                  ),
                  const SizedBox(width: 17),
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_downward_rounded,
                              size: 18,
                              color: blackTint,
                            ),
                            SizedBox(width: 5),
                            SubText(
                              text: '24h low',
                              textSize: 12,
                              foreground: blackTint,
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        if (candlestick != null)
                          SubText(
                            text: '${candlestick.candle.low.formatAsRoundedInteger()} -1%',
                            textSize: 14,
                          )
                        else
                          const SubText(
                            text: '0.00 -0.00%',
                            textSize: 14,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
