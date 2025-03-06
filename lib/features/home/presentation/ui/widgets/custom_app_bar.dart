import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).shadowColor,
          width: 1.5,
        )),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(context.isDarkMode() ? ImageAssets.logoLight : ImageAssets.logoDark),
        actions: [
          Image.asset(ImageAssets.user, width: 40, height: 40),
          const SizedBox(width: 15),
          SvgPicture.asset(ImageAssets.globe, width: 24, height: 24),
          const SizedBox(width: 15),
          TapArea(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child: SvgPicture.asset(ImageAssets.menu, width: 24, height: 24),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
