import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:get/utils.dart';
import 'package:raven_pay/shared/extensions/double_extension.dart';

import '../../../core/values/colors/app_colors.dart';
import '../../../core/values/strings/app_assets.dart';
import '../../../core/values/styles/sizing_config.dart';
import '../../../data/models/data_models/order_book_model.dart';
import '../../../shared/widgets/app_text.dart';
import '../../../shared/widgets/gap.dart';
import '../controllers/home_controller.dart';

class OrderBookSection extends StatefulWidget {
  const OrderBookSection({super.key});

  @override
  State<OrderBookSection> createState() => _OrderBookSectionState();
}

class _OrderBookSectionState extends State<OrderBookSection> {
  final controller = Get.find<HomeController>();

  OrderBook? get orderBooks => controller.orderBooks.value;

  String? selectedValue;

  // final List<String> items = [
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? const Color(0xff353945)
                            : const Color(0xffCFD3D8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.select_1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          // color: Color(0xffCFD3D8),
                          ),
                      child: SvgPicture.asset(
                        AppAssets.select_2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: const BoxDecoration(
                          // color: Color(0xffCFD3D8),
                          ),
                      child: SvgPicture.asset(
                        AppAssets.select_3,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? const Color(0xff353945)
                        : const Color(0xffCFD3D8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 65,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded:
                                false, // Allow normal behavior (icon and value visible)
                            hint: Text(
                              selectedValue != null ? '$selectedValue' : '10',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            value: selectedValue,
                            items: [
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10'
                            ]
                                .map(
                                  (String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue =
                                    value; // Update the selected value
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                                height: 40,
                                width: 120, // Adjust width to fit content
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                overlayColor:
                                    WidgetStatePropertyAll(Colors.black38)),
                            menuItemStyleData:
                                const MenuItemStyleData(height: 40),
                          ),
                        ),
                      ),
                      // AppDropdownButton(),
                      // AppText.caption(
                      //   '10',
                      // ),
                      // const Gap(5),
                      // const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // * ORDER BOOK TITLES
          const Gap(12),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body2(
                      'Price',
                      color: context.isDarkMode
                          ? AppColors.blackTint
                          : AppColors.blackTint2,
                    ),
                    const Gap(5),
                    AppText.small(
                      'USDT',
                      color: context.isDarkMode
                          ? AppColors.blackTint
                          : AppColors.blackTint2,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body2(
                      'Amounts',
                      color: context.isDarkMode
                          ? AppColors.blackTint
                          : AppColors.blackTint2,
                    ),
                    const Gap(5),
                    AppText.small(
                      'BTC',
                      color: context.isDarkMode
                          ? AppColors.blackTint
                          : AppColors.blackTint2,
                    )
                  ],
                ),
                AppText.body2(
                  'Total',
                  color: context.isDarkMode
                      ? AppColors.blackTint
                      : AppColors.blackTint2,
                ),
              ],
            ),
          ),
          const Gap(15),
          // * ORDER BOOK UI DISPLAY
          if (orderBooks != null) ...[
            Column(
              children: List.generate(
                orderBooks!.asks!.length > 5 ? 5 : orderBooks!.asks!.length,
                (index) => Stack(
                  children: [
                    Gap.h10,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        color: const Color(0xffFF6838).withOpacity(.15),
                        height: 28,
                        width: (double.tryParse(orderBooks!.asks![index]![0])! *
                                double.tryParse(
                                    orderBooks!.asks![index]![1])!) /
                            100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body1(
                            '${double.tryParse(orderBooks!.asks![index]![0]!.toString())}',
                            color: const Color(0xffFF6838),
                          ),
                          AppText.body1(
                            double.tryParse(
                              orderBooks!.asks![index]![1]!.toString(),
                            )!
                                .toStringAsFixed(3),
                          ),
                          AppText.body1(
                            (double.tryParse(orderBooks!.asks![index]![0])! +
                                    double.tryParse(
                                        orderBooks!.asks![index]![1])!)
                                .formatValue2(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(19),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (orderBooks!.asks!.length >= 2 &&
                    orderBooks!.asks![0]!.isNotEmpty) ...[
                  AppText.body1(
                    '${double.tryParse(orderBooks!.asks![1]![0]!.toString())}',
                    color: const Color(0xff25C26E),
                    fontSize: 16,
                  ),
                  const Gap(13),
                  Icon(
                    Icons.arrow_upward_rounded,
                    size: 18,
                    color: context.isDarkMode
                        ? AppColors.blackTint
                        : const Color(0xff25C26E),
                  ),
                  const Gap(13),
                  AppText.body1(
                    '${double.tryParse(orderBooks!.bids![1]![0]!.toString())}',
                    fontSize: 16,
                    color: context.isDarkMode
                        ? AppColors.white
                        : AppColors.primaryBlack,
                  ),
                ]
              ],
            ),
            const Gap(19),
            Column(
              children: List.generate(
                orderBooks!.bids!.length > 5 ? 5 : orderBooks!.bids!.length,
                (index) => Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        color: const Color(0xff25C26E).withOpacity(.15),
                        height: 30,
                        width: (double.tryParse(orderBooks!.bids![index]![0])! *
                                double.tryParse(
                                    orderBooks!.bids![index]![1])!) /
                            100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body1(
                            '${double.tryParse(orderBooks!.bids![index]![0]!.toString())}',
                            color: const Color(0xffFF6838),
                          ),
                          AppText.body1(
                            double.tryParse(
                              orderBooks!.bids![index]![1]!.toString(),
                            )!
                                .toStringAsFixed(3),
                          ),
                          AppText.body1(
                            (double.tryParse(orderBooks!.bids![index]![0])! +
                                    double.tryParse(
                                        orderBooks!.bids![index]![1])!)
                                .formatValue2(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const Gap(19),
        ],
      ),
    );
  }
}
