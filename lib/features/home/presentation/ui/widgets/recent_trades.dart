import 'package:flutter/material.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class RecentTradesPlaceholder extends StatelessWidget {
  const RecentTradesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(
        children: [
          Align(alignment: Alignment.topLeft, child: HeaderText(text: 'Recent Trades')),
          SizedBox(height: 100),
          SubText(
            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
