import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/theme_notifier.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  final drawerItems = const ['Exchange', 'Wallets', 'Roqqu Hub', 'Log out'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 65,
          right: 10,
          child: Container(
            width: 214,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).shadowColor, width: 1.5),
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
    );
  }
}
