import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import '../../core/values/colors/app_colors.dart';
import 'widgets.dart';

class TradeBottomSheet extends StatefulWidget {
  const TradeBottomSheet({super.key});

  @override
  State<TradeBottomSheet> createState() => _TradeBottomSheetState();
}

class _TradeBottomSheetState extends State<TradeBottomSheet> {
  List<bool> isSelected = [true, false];
  bool isChecked = false;
  final List<String> options = [
    'Limit',
    'Market',
    'Stop-Limit',
  ];
  int selectedValue = 0;
  String selectedOption = 'Limit';
  final _limitPriceController = TextEditingController();
  final _amountController = TextEditingController();
  final _typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 34, 30, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? AppColors.black.withOpacity(.16)
                    : const Color(0xffF1F1F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => selectedValue = 0),
                          child: Container(
                            width: 170,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: selectedValue == 0
                                  ? (context.isDarkMode
                                      ? AppColors.white.withOpacity(.06)
                                      : AppColors.white)
                                  : (context.isDarkMode
                                      ? AppColors.black.withOpacity(.16)
                                      : const Color(0xffF1F1F1)),
                              border: Border.all(
                                color: selectedValue == 0
                                    ? (context.isDarkMode
                                        ? AppColors.green
                                        : AppColors.green)
                                    : (context.isDarkMode
                                        ? AppColors.black.withOpacity(.16)
                                        : const Color(0xffF1F1F1)),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(child: AppText.body1('Buy')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => selectedValue = 1),
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: selectedValue == 0
                                  ? (context.isDarkMode
                                      ? AppColors.black.withOpacity(.16)
                                      : const Color(0xffF1F1F1))
                                  : (context.isDarkMode
                                      ? AppColors.white.withOpacity(.06)
                                      : AppColors.white),
                              border: Border.all(
                                color: selectedValue == 0
                                    ? (context.isDarkMode
                                        ? AppColors.black.withOpacity(.16)
                                        : const Color(0xffF1F1F1))
                                    : (context.isDarkMode
                                        ? AppColors.green
                                        : AppColors.green),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(child: AppText.body1('Sell')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...options.map(
                  (e) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = e;
                      });
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
                        color: selectedOption == e
                            ? context.isDarkMode
                                ? const Color(0xff555C63)
                                : const Color(0xffCFD3D8)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: AppText.body1(
                          e,
                          color: context.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(16),
            InputField(
              hintText: 'Limit price',
              suffixText: '0.00 USD',
              controller: _limitPriceController,
            ),
            const Gap(16),
            InputField(
              hintText: 'Amount',
              suffixText: '0.00 USD',
              controller: _amountController,
            ),
            const Gap(16),
            InputField(
              isReadOnly: true,
              hintText: 'Type',
              suffixText: 'Good till cancelled',
              controller: _typeController,
            ),
            const Gap(16),
            AppCheckbox(
              value: isChecked,
              onSwitch: (value) {
                setState(() {
                  isChecked = value;
                });
              },
              text: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    AppText.body1(
                      'Post Only',
                    ),
                    const Gap(6),
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.body1(
                  'Total',
                ),
                AppText.body2(
                  '0.00',
                ),
              ],
            ),
            const Gap(16),
            AppGradientButton(
              width: double.infinity,
              title: 'Buy BTC',
              onPressed: () {},
            ),
            const Gap(15),
            Divider(
              color: AppColors.blackTint.withOpacity(.1),
              thickness: 1,
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.body2(
                  'Total account value',
                ),
                Row(
                  children: [
                    AppText.body1(
                      'NGN',
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: AppColors.blackTint,
                    )
                  ],
                ),
              ],
            ),
            const Gap(8),
            AppText.body1(
              '0.00',
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.body1(
                  'Open Orders',
                ),
                AppText.body2(
                  'Available',
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.body1(
                  '0.00',
                ),
                AppText.body1(
                  '0.00',
                ),
              ],
            ),
            const Gap(32),
            AppButton(
              title: 'Deposit',
              onPressed: () {},
              color: const Color(0xff2764FF),
            ),
          ],
        ),
      ),
    );
  }
}
