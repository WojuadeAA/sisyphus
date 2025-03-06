import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/core/enums/enums.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/bottom_sheet.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/charts.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/orderbook.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/summary_card_widget.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/trades.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/symbol_notifier.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/theme_notifier.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final drawerItems = [
    'Exchange',
    'Wallets',
    'Roqqu Hub',
    'Log out',
  ];
  late final tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    ref.watch(symbolNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: Stack(
        children: [
          Positioned(
            top: 65,
            right: 10,
            child: Container(
              width: 214,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final themeMode = ref.watch(themeNotifierProvider);

                      return InkWell(
                        onTap: () {
                          ref.read(themeNotifierProvider.notifier).toggleTheme();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 13,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                themeMode == ThemeMode.system
                                    ? Icons.brightness_auto
                                    : themeMode == ThemeMode.dark
                                        ? Icons.nightlight_round
                                        : Icons.wb_sunny,
                                color: context.isDarkMode() ? white : blackTint2,
                              ),
                              const SizedBox(width: 15),
                              SubText(
                                text: themeMode == ThemeMode.system
                                    ? 'System Theme'
                                    : themeMode == ThemeMode.dark
                                        ? 'Dark Theme'
                                        : 'Light Theme',
                                textSize: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ...drawerItems.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: SubText(
                        text: e,
                        textSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      key: _key,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).shadowColor,
                width: 1.5,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                SvgPicture.asset(context.isDarkMode() ? ImageAssets.logoLight : ImageAssets.logoDark),
              ],
            ),
            actions: [
              Image.asset(ImageAssets.user, width: 40, height: 40),
              const SizedBox(width: 15),
              SvgPicture.asset(ImageAssets.globe, width: 24, height: 24),
              const SizedBox(width: 15),
              TapArea(
                  onTap: () {
                    _key.currentState!.openEndDrawer();
                  },
                  child: SvgPicture.asset(ImageAssets.menu, width: 24, height: 24)),
              const SizedBox(width: 14),
              const SizedBox(width: 14),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: 120,
        ),
        children: [
          const SizedBox(height: 8),
          const SummaryCardWidget(),
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).shadowColor,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 42,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).shadowColor,
                      width: 1.5,
                    ),
                  ),
                  child: TabBar(
                    controller: tabController,
                    padding: const EdgeInsets.all(2),
                    labelStyle: const TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    tabs: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Charts'),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Orderbook'),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Recent trades'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 550,
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const Charts(),
                      const Orderbook(),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.all(20),
                        child: const HeaderText(
                          text: 'Recent Trades',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 9),
          const Trades(),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).shadowColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff25C26E)),
                onPressed: () {
                  context.openBottomSheet(ActionBottomSheet(userAction: UserAction.buy));
                },
                child: const Text('Buy'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF554A),
                ),
                onPressed: () {
                  context.openBottomSheet(ActionBottomSheet(userAction: UserAction.sell));
                },
                child: const Text('Sell'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
