import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';
import 'package:raven_pay/shared/extensions/extensions.dart';

import '../../../core/values/colors/app_colors.dart';
import '../../../core/values/strings/app_assets.dart';
import '../../../core/values/strings/text_constants.dart';
import '../../../core/values/styles/text_styles.dart';
import '../../../shared/theme_controller.dart';
import '../../../shared/widgets/app_text.dart';
import '../../../shared/widgets/circular_progress_indicator.dart';
import '../../../shared/widgets/gap.dart';
import '../components/bottom_sheet_section.dart';
import '../components/candle_sticks_section.dart';
import '../components/order_book_section.dart';
import '../components/price_change_section.dart';
import '../components/trades_section.dart';
import '../controllers/home_controller.dart';

final drawerItems = [
  'Exchange',
  'Wallets',
  'Roqqu Hub',
  'Log out',
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HomeController());
  final themeController = Get.put(ThemeController());
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    controller.init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: true,
        endDrawer: Stack(
          children: [
            Positioned(
              top: 65,
              right: 10,
              child: Container(
                //height: context.isDarkMode ? 208 : 256,
                height: 320,
                width: 214,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap.h10,
                    Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.blackTint,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: TextField(
                        style: bodyStyle1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.only(left: 12, top: 8),
                          hintText: "Search",
                          hintStyle: bodyStyle1,
                          suffixIcon: const Icon(
                            CupertinoIcons.search,
                            color: AppColors.blackTint,
                          ),
                        ),
                      ),
                    ),
                    ...drawerItems.map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                        child: AppText.body1(e),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 13,
                        bottom: 13,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              child: CupertinoSwitch(
                                value: themeController.currentTheme.value ==
                                    ThemeMode.dark,
                                onChanged: (value) {
                                  themeController.switchTheme();
                                  Get.changeThemeMode(
                                      themeController.currentTheme.value);
                                },
                              ),
                            ),
                          ),
                          10.width,
                          AppText.body1(
                            'Theme Mode',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        key: controller.scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(63),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
            ),
            child: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: SvgPicture.asset(
                AppAssets.company_logo,
                // ignore: deprecated_member_use
                color: context.isDarkMode ? Colors.white : null,
              ),
              actions: [
                Row(
                  children: [
                    Image.asset(AppAssets.avatar),
                    Gap.w16,
                    SvgPicture.asset(AppAssets.internet),
                    Gap.w16,
                    InkWell(
                      onTap: () {
                        if (controller
                            .scaffoldKey.currentState!.isEndDrawerOpen) {
                          controller.scaffoldKey.currentState?.closeEndDrawer();
                        } else {
                          controller.scaffoldKey.currentState?.openEndDrawer();
                        }
                      },
                      child: SvgPicture.asset(AppAssets.menu),
                    )
                  ],
                ),
                Gap.w14,
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () =>
              controller.reInitialize(controller.currentInterval.value),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap.h8,
                  PriceChangeSection(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).shadowColor,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicatorPadding: EdgeInsets.all(2),
                            dividerColor: Theme.of(context).shadowColor,
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            labelStyle: const TextStyle(
                              fontFamily: SATOSHI,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            tabs: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText.body2('Charts'),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText.body2('Orderbook'),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText.body2('Recent trades'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 950,
                          child: TabBarView(
                            controller: _tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              CandleSticksSection(
                                currentInterval:
                                    controller.currentInterval.value,
                              ),
                              controller.candleLoading.value
                                  ? CircularProgressWidget(
                                      valueColor: AppColors.green)
                                  : OrderBookSection(),
                              Container(
                                height: 30,
                                padding: const EdgeInsets.all(20),
                                child: AppText.heading5(
                                  'Recent Trades',
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Gap.h30,
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).shadowColor,
                        width: 1.5,
                      ),
                    ),
                    child: const TradesSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: const BottomSheetSection(),
      ),
    );
  }
}
