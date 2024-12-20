import 'dart:async';
import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/utils/app_logger.dart';
import '../../../core/values/strings/text_constants.dart';
import '../../../data/enums/base_enums.dart';
import '../../../data/models/data_models/candle_stick_ticker_model.dart';
import '../../../data/models/data_models/order_book_model.dart';
import '../../../data/models/dto_models/stream_value_dto.dart';
import '../../../data/models/errors/app_error.dart';
import '../../../data/models/errors/failure.dart';
import '../../../data/models/response_models/symbol_response_model.dart';
import '../../../shared/shared_controller.dart';

class HomeController extends GetxController with GlobalController {
  final _logger = appLogger(HomeController);

// VARIABLES
  RxInt selectedInterval = 0.obs;
  RxList<SymbolResponseModel> symbols = <SymbolResponseModel>[].obs;
  WebSocketChannel? channel;
  RxString selectedNumber = ''.obs;

  RxList<Candle> candles = <Candle>[].obs;
  RxString currentInterval = "1H".obs;
  Rx<SymbolResponseModel> currentSymbol =
      SymbolResponseModel(symbol: 'BTCUSDT', price: '').obs;
  RxInt currentTabIndex = 0.obs;
  RxInt bottomTabIndex = 0.obs;
  Rx<ModuleState> moduleState = (ModuleState.idle).obs;
  Rx<Failure> moduleError =
      ModuleFailure(failureMessage: '', failureTitle: '').obs;

  Rxn<CandleTickerModel> candleTicker = Rxn<CandleTickerModel>();
  Rxn<OrderBook> orderBooks = Rxn<OrderBook>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RxBool candleLoading = false.obs;
  RxBool symbolLoading = false.obs;
  RxBool websocketLoading = false.obs;
  RxBool reInitializing = false.obs;

  @override
  onInit() {
    _logger.d('==== \n\nHOME CONTROLLER CALLED!\n\n ====');
    init();
    super.onInit();
  }

  @override
  void onClose() {
    channel?.sink.close();
    super.onClose();
  }

  // ENTRY POINT
  // Get the symbols, then get the candles and if they are not available,
  //then initialize websocket and get needed data
  void init() {
    _logger.d("initializing ...");
    fetchSymbols();
    fetchCandles(currentSymbol.value, currentInterval.value).then((value) {
      if (candleTicker.value == null) {
        initializeWebSocket(
          interval: currentInterval.value,
          symbol: currentSymbol.value.symbol,
        );
      }
    });
  }

  // GET SYMBOLS
  Future<void> fetchSymbols() async {
    _logger.d("Getting Symbols.....");
    symbolLoading.value = true;
    try {
      moduleState.value = ModuleState.busy;
      final result = await binanceRepository.fetchSymbols();
      symbols.value = result;
      _logger.d("Symbols Length ===> ${symbols.length}");
      if (symbols.isNotEmpty) {
        currentSymbol.value = symbols[11];
      }
      moduleState.value = ModuleState.idle;
    } on Failure catch (e) {
      moduleState.value = ModuleState.error;
      // moduleError.value = e;
      _logger.e(e.message);
    } catch (e) {
      _logger.e(e.toString());
      final err =
          AppError("unknown error", "an error occurred, please try again.");
      moduleState.value = ModuleState.error;
      moduleError.value = err;
    }
    symbolLoading.value = false;
  }

  // GET THE CANDLES
  Future<List<Candle>> fetchCandles(
      SymbolResponseModel symbol, String interval) async {
    _logger.d("Getting Candles......");
    candleLoading.value = false;
    try {
      moduleState.value = ModuleState.busy;
      final result = await binanceRepository.fetchCandles(
        symbol: symbol.symbol,
        interval: interval.toLowerCase(),
      );
      if (candles.isEmpty) {
        _logger.e("Candles data is empty");
        // return candles;
      }
      candles.value = result;
      _logger.d("Candles Length :: ${candles.length}");
      moduleState.value = ModuleState.idle;
      candleLoading.value = false;
      return result;
    } on Failure catch (e) {
      if (moduleState.value == ModuleState.error) {
        Get.snackbar("Error", moduleError.value.message);
      }
      // moduleState.value = ModuleState.error;
      // moduleError.value = e;
      _logger.e(e.message);
      candleLoading.value = false;
      return candles;
    } catch (e) {
      _logger.e(e.toString());
      final err =
          AppError("unknown error", "an error occurred, please try again.");
      moduleState.value = ModuleState.error;
      moduleError.value = err;
      candleLoading.value = false;
      return candles;
    }
  }

  // INITIALIZE THE WEBSOCKET
  Future<void> initializeWebSocket({
    required String symbol,
    required String interval,
  }) async {
    if (channel != null) {
      channel?.sink.close();
    }

    _logger.d("Initializing websocket..");
    websocketLoading.value = true;

    final chn = binanceRepository.establishSocketConnection(
      interval: interval.toLowerCase(),
      symbol: symbol.toLowerCase(),
    );

    try {
      await for (final String value in chn.stream) {
        final map = jsonDecode(value) as Map<String, dynamic>;
        final eventType = map['e'];

        if (eventType == KLINE) {
          final candleTickerInfo = CandleTickerModel.fromJson(map);
          candleTicker.value = candleTickerInfo;
          if (candles.isNotEmpty &&
              candles[0].date == candleTicker.value!.candle.date &&
              candles[0].open == candleTickerInfo.candle.open) {
            candles[0] = candleTickerInfo.candle;
          } else if (candles.isNotEmpty &&
              candleTicker.value!.candle.date.difference(candles[0].date) ==
                  candles[0].date.difference(candles[1].date)) {
            candles.insert(0, candleTicker.value!.candle);
          }
        } else if (eventType == DEPTH_UPDATE) {
          final orderBookInfo = OrderBook.fromMap(map);
          orderBooks.value = orderBookInfo;
        }
      }
      websocketLoading.value = false;
    } catch (e) {
      websocketLoading.value = false;
      _logger.e("WebSocket Error: $e");
    }
  }

  // TO LOAD MORE CANDLES
  Future<void> loadMoreCandles(StreamValueDTO streamValue) async {
    _logger.d("Loading more candles..");
    try {
      final data = await binanceRepository.fetchCandles(
        symbol: streamValue.symbol.symbol,
        interval: streamValue.interval!,
        endTime: candles.last.date.millisecondsSinceEpoch,
      );
      candles
        ..removeLast()
        ..addAll(data);
    } on Failure catch (e) {
      _logger.d("Custom Error fetching candles ==> ${e.message}");
    } catch (e) {
      _logger.d("Error fetching more candles ::: ${e.toString()}");
    }
  }

  // RE_INITIALIZE FROM HOMEPAGE
  Future<void> reInitialize(String value) async {
    _logger.d("Re-Initializing..");
    reInitializing.value = true;
    // currentInterval.value = value;
    if (currentSymbol.value.symbol != '') {
      fetchCandles(currentSymbol.value, currentInterval.value).then((value) {
        if (candleTicker.value == null) {
          initializeWebSocket(
            interval: currentInterval.value,
            symbol: currentSymbol.value.symbol,
          );
        }
      });
    }
    reInitializing.value = false;
  }
}
