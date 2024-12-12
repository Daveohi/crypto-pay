import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:raven_pay/shared/extensions/extensions.dart';

import '../../../core/values/colors/app_colors.dart';
import '../../../core/values/strings/app_assets.dart';
import '../../../core/values/styles/sizing_config.dart';
import '../../../shared/widgets/app_text.dart';
import '../../../shared/widgets/gap.dart';
import '../controllers/home_controller.dart';

class PriceChangeSection extends StatelessWidget {
  PriceChangeSection({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
            const Gap(20),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizingConfig.defaultPadding - 2,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.btc_usd,
                    width: 44,
                    height: 24,
                  ),
                  const Gap(8),
                  if (controller.currentSymbol.value.symbol != '') ...[
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.heading5(
                            controller.currentSymbol.value.symbol,
                          ),
                          const Gap(10),
                          const Padding(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                          const Gap(67),
                          AppText.heading5(
                            controller.currentSymbol.value.price == ''
                                ? r'$0.0'
                                : '\$${double.tryParse(controller.currentSymbol.value.price).formatValue()}',
                            // r'$20.634',
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Gap(18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 102,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 18,
                                color: AppColors.blackTint,
                              ),
                              const Gap(5),
                              AppText.body2(
                                '24h change',
                                color: AppColors.blackTint,
                              )
                            ],
                          ),
                          const Gap(5),
                          if (controller.candleTicker.value != null)
                            AppText.body1(
                              '${controller.candleTicker.value!.candle.volume.formatValue2()} +1%',
                              color: AppColors.green,
                            )
                          else
                            AppText.body1(
                              '0.00 +0.00%',
                              color: AppColors.green,
                            )
                        ],
                      ),
                    ),
                    const Gap(17),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.divider.withOpacity(.08),
                    ),
                    const Gap(17),
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_upward_rounded,
                                size: 18,
                                color: AppColors.blackTint,
                              ),
                              const Gap(5),
                              AppText.body2(
                                '24h high',
                                color: AppColors.blackTint,
                              )
                            ],
                          ),
                          const Gap(5),
                          if (controller.candleTicker.value != null)
                            AppText.body1(
                              '${controller.candleTicker.value!.candle.high.formatValue()} +1%',
                            )
                          else
                            AppText.body1(
                              '0.00 +0.00%',
                            )
                        ],
                      ),
                    ),
                    const Gap(17),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.divider.withOpacity(.08),
                    ),
                    const Gap(17),
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_downward_rounded,
                                size: 18,
                                color: AppColors.blackTint,
                              ),
                              const Gap(5),
                              AppText.body2(
                                '24h low',
                                color: AppColors.blackTint,
                              )
                            ],
                          ),
                          const Gap(5),
                          if (controller.candleTicker.value != null)
                            AppText.body1(
                              '${controller.candleTicker.value!.candle.low.formatValue()} -1%',
                            )
                          else
                            AppText.body1(
                              '0.00 -0.00%',
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
      ),
    );
  }
}
