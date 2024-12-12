import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:raven_pay/core/values/styles/sizing_config.dart';
import 'package:raven_pay/shared/widgets/trade_bottom_sheet.dart';
import 'package:raven_pay/shared/widgets/trade_buttons.dart';

import '../../../core/values/colors/app_colors.dart';

class BottomSheetSection extends StatelessWidget {
  const BottomSheetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.only(bottom: SizingConfig.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TradeButton(
              type: TradeType.Buy,
              onPressed: () => displayBottomSheet(context, TradeType.Buy),
            ),
            TradeButton(
              type: TradeType.Sell,
              onPressed: () => displayBottomSheet(context, TradeType.Sell),
            )
          ],
        ),
      ),
    );
  }
}

void displayBottomSheet(
  BuildContext context,
  TradeType tradeAction,
) {
  showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    backgroundColor:
        context.isDarkMode ? const Color(0xff20252B) : AppColors.white,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext buildContext) {
      return const TradeBottomSheet();
    },
  );
}
