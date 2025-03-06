import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/enums/enums.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/bottom_sheet.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/charts.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/orderbook.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/summary_card_widget.dart';
import 'package:sisyphus/features/home/presentation/ui/widgets/trades.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/symbol_notifier.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/menu_drawer.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late final tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    ref.watch(symbolNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: const MenuDrawer(),
      key: _scaffoldKey,
      appBar: const CustomAppBar(),
      body: _MainContent(tabController: tabController),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).shadowColor, width: 1.5),
        ),
        child: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ActionButton(
                color: Color(0xff25C26E),
                text: 'Buy',
                action: UserAction.buy,
              ),
              SizedBox(width: 16),
              _ActionButton(
                color: Color(0xffFF554A),
                text: 'Sell',
                action: UserAction.sell,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  final TabController tabController;

  const _MainContent({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 120),
      children: [
        const SizedBox(height: 8),
        const SummaryCardWidget(),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: _tabSectionDecoration(context),
          child: Column(
            children: [
              _TabBarSection(tabController: tabController),
              _TabViewSection(tabController: tabController),
            ],
          ),
        ),
        const SizedBox(height: 9),
        const Trades(),
      ],
    );
  }

  BoxDecoration _tabSectionDecoration(BuildContext context) => BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).shadowColor, width: 1.5),
      );
}

class _TabBarSection extends StatelessWidget {
  final TabController tabController;

  const _TabBarSection({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.all(15),
      decoration: _tabBarDecoration(context),
      child: TabBar(
        controller: tabController,
        padding: const EdgeInsets.all(2),
        labelStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        tabs: const [
          _TabItem(text: 'Charts'),
          _TabItem(text: 'Orderbook'),
          _TabItem(text: 'Recent trades'),
        ],
      ),
    );
  }

  BoxDecoration _tabBarDecoration(BuildContext context) => BoxDecoration(
        color: Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).shadowColor, width: 1.5),
      );
}

class _TabItem extends StatelessWidget {
  final String text;

  const _TabItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Text(text),
    );
  }
}

class _TabViewSection extends StatelessWidget {
  final TabController tabController;

  const _TabViewSection({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Charts(),
          Orderbook(),
          RecentTradesPlaceholder(),
        ],
      ),
    );
  }
}

class RecentTradesPlaceholder extends StatelessWidget {
  const RecentTradesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(20),
      child: const HeaderText(text: 'Recent Trades'),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Color color;
  final String text;
  final UserAction action;

  const _ActionButton({
    required this.color,
    required this.text,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () => context.openBottomSheet(ActionBottomSheet(userAction: action)),
      child: Text(text),
    );
  }
}
