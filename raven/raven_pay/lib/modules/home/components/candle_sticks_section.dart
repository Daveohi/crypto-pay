import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:raven_pay/shared/extensions/extensions.dart';
import 'package:raven_pay/shared/widgets/app_text.dart';

import '../../../core/values/colors/app_colors.dart';
import '../../../core/values/strings/app_assets.dart';
import '../../../data/models/data_models/candle_stick_ticker_model.dart';
import '../../../data/models/dto_models/stream_value_dto.dart';
import '../../../data/models/response_models/symbol_response_model.dart';
import '../../../shared/widgets/circular_progress_indicator.dart';
import '../../../shared/widgets/gap.dart';
import '../controllers/home_controller.dart';
import 'time_frame_section.dart';

class CandleSticksSection extends StatefulWidget {
  final String currentInterval;

  const CandleSticksSection({
    super.key,
    required this.currentInterval,
  });

  @override
  State<CandleSticksSection> createState() => _CandleSticksSectionState();
}

class _CandleSticksSectionState extends State<CandleSticksSection> {
  GlobalKey<_CandleSticksSectionState> candleStickKey = GlobalKey();

  final controller = Get.find<HomeController>();
  CandleTickerModel? get candleTicker => controller.candleTicker.value;
  SymbolResponseModel? get currentSymbol => controller.currentSymbol.value;
  List<Candle> get candles => controller.candles;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const Gap(7),
          TimeFrameSection(
            onSelected: (value) {
              controller.reInitialize(value);
            },
          ),
          const Gap(15),
          Divider(
            color: AppColors.blackTint.withOpacity(.1),
            thickness: 1,
          ),
          Divider(
            color: AppColors.blackTint.withOpacity(.1),
            thickness: 1,
          ),
          if (candles.isNotEmpty)
            controller.candleLoading.value
                ? CircularProgressWidget(valueColor: AppColors.green)
                : SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Candlesticks(
                      key: candleStickKey,
                      candles: controller.candles,
                      onLoadMoreCandles: () {
                        return controller.loadMoreCandles(
                          StreamValueDTO(
                            symbol: currentSymbol!,
                            interval: widget.currentInterval.toLowerCase(),
                          ),
                        );
                      },
                      actions: [
                        ToolBarAction(
                          width: 20,
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SvgPicture.asset(
                              AppAssets.rounded_arrow_down,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        ToolBarAction(
                          width: 50,
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: AppText.caption(
                              currentSymbol!.symbol,
                              fontSize: 8,
                              color: AppColors.blackTint2,
                            ),
                          ),
                        ),
                        if (candleTicker != null)
                          ToolBarAction(
                            width: 55,
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 1),
                              child: Row(
                                children: [
                                  AppText.body2(
                                    'O ',
                                    fontSize: 8,
                                    color: AppColors.blackTint2,
                                  ),
                                  AppText.body2(
                                    candleTicker?.candle.open.formatValue() ??
                                        "-",
                                    fontSize: 8,
                                    color: AppColors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (candleTicker != null)
                          ToolBarAction(
                            width: 55,
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 1),
                              child: Row(
                                children: [
                                  AppText.body2(
                                    'H ',
                                    fontSize: 8,
                                    color: AppColors.blackTint2,
                                  ),
                                  AppText.body2(
                                    candleTicker?.candle.high.formatValue() ??
                                        "-",
                                    fontSize: 8,
                                    color: AppColors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (candleTicker != null)
                          ToolBarAction(
                            width: 55,
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 1),
                              child: Row(
                                children: [
                                  AppText.body2(
                                    'L ',
                                    fontSize: 8,
                                    color: AppColors.blackTint2,
                                  ),
                                  AppText.body2(
                                    candleTicker?.candle.low.formatValue() ??
                                        "-",
                                    fontSize: 8,
                                    color: AppColors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (candleTicker != null)
                          ToolBarAction(
                            width: 57,
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText.body2(
                                    'C ',
                                    fontSize: 8,
                                    color: AppColors.blackTint2,
                                  ),
                                  AppText.body2(
                                    candleTicker?.candle.close.formatValue() ??
                                        "-",
                                    fontSize: 8,
                                    color: AppColors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
        ],
      ),
    );
  }
}
