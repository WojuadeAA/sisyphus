import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/core/enums/enums.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/textfields.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class ActionBottomSheet extends HookWidget {
  ActionBottomSheet({super.key, required this.userAction});
  final UserAction userAction;

  final List<String> options = [
    'Limit',
    'Market',
    'Stop-Limit',
  ];

  @override
  Widget build(BuildContext context) {
    final selectedValue = useState(0);
    final selectedOption = useState('Limit');
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 34, 30, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  CupertinoSlidingSegmentedControl(
                    backgroundColor: context.isDarkMode() ? black.withOpacity(.16) : const Color(0xffF1F1F1),
                    thumbColor: context.isDarkMode() ? const Color(0xff21262C) : white,
                    padding: const EdgeInsets.all(3),
                    groupValue: selectedValue.value,
                    children: {
                      0: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: SubText(
                            text: 'Buy',
                          ),
                        ),
                      ),
                      1: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: SubText(
                            text: 'Sell',
                          ),
                        ),
                      ),
                    },
                    onValueChanged: (value) {
                      selectedValue.value = value!;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...options.map(
                  (e) => InkWell(
                    onTap: () {
                      selectedOption.value = e;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: selectedOption.value == e
                            ? context.isDarkMode()
                                ? const Color(0xff555C63)
                                : const Color(0xffCFD3D8)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: SubText(
                          text: e,
                          textSize: 14,
                          foreground: context.isDarkMode() ? white : rockBlack,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InputField(
              hintText: 'Limit price',
              suffixText: '0.00 USD',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            InputField(
              hintText: 'Amount',
              suffixText: '0.00 USD',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            InputField(
              isReadOnly: true,
              hintText: 'Type',
              suffixText: 'Good till cancelled',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            CustomCheckbox(
              value: true,
              onSwitch: (val) {},
              text: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    SubText(
                      text: 'Post Only',
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubText(
                  text: 'Total',
                  textSize: 12,
                  foreground: blackTint,
                ),
                SubText(
                  text: '0.00',
                  textSize: 12,
                  foreground: blackTint,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff483BEB),
                    Color(0xff7847E1),
                    Color(0xffDD568D),
                  ],
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: () {},
                child: Text(
                  selectedValue.value == 0 ? "Buy BTC" : "Sell BTC",
                ),
              ),
            ),
            const SizedBox(height: 15),
            Divider(
              color: blackTint.withOpacity(.1),
              thickness: 1,
            ),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubText(
                  text: 'Total account value',
                  textSize: 12,
                  foreground: blackTint,
                ),
                Row(
                  children: [
                    SubText(
                      text: 'NGN',
                      textSize: 12,
                      foreground: blackTint,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: blackTint,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const SubText(
              text: '0.00',
              textSize: 14,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubText(
                  text: 'Open Orders',
                  textSize: 12,
                  foreground: blackTint,
                ),
                SubText(
                  text: 'Available',
                  textSize: 12,
                  foreground: blackTint,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubText(
                  text: '0.00',
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SubText(
                  text: '0.00',
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2764FF),
              ),
              onPressed: () {},
              child: const Text(
                'Deposit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
