// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:raven_pay/shared/extensions/extensions.dart';

import '../../../core/values/styles/sizing_config.dart';
import '../../../shared/widgets/app_text.dart';

class TabIndicator extends StatelessWidget {
  final int currentIndex;
  final void Function(int index)? onTap;
  final List<String> options;

  const TabIndicator({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: context.getDeviceWidth,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      margin: EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
      decoration: BoxDecoration(
        color: Color(0xffCFD3D8),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            options.length,
            (index) => GestureDetector(
              onTap: () {
                onTap?.call(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                height: 34,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: currentIndex == index
                    ? const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      )
                    : const BoxDecoration(),
                child: AppText.body1(
                  options[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
