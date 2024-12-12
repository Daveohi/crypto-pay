import 'package:flutter/material.dart';

import '../../../core/values/colors/app_colors.dart';
import '../../../shared/widgets/app_text.dart';
import '../../../shared/widgets/gap.dart';

class PriceChangeComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String priceChange;
  final bool isIncrease;
  const PriceChangeComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.priceChange,
    this.isIncrease = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: AppColors.grey,
              ),
              Gap.w4,
              AppText.body2(
                title,
                color: AppColors.grey,
              ),
            ],
          ),
          Gap.h4,
          AppText.body1(
            priceChange,
            color: isIncrease ? AppColors.green : null,
          )
        ],
      ),
    );
  }
}
