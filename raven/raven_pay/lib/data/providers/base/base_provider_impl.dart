import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/utils/app_logger.dart';
import '../../../shared/shared_controller.dart';
import '../../models/response_models/symbol_response_model.dart';
import 'base_provider.dart';

class BaseProviderImpl with GlobalController implements BaseProvider {
  final _logger = appLogger(BaseProviderImpl);

  @override
  WebSocketChannel establishSocketConnection({
    required String symbol,
    required String interval,
  }) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@kline_$interval'],
          'id': 1
        },
      ),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@depth'],
          'id': 1
        },
      ),
    );

    return channel;
  }

  @override
  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    final String uri =
        "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? "&endTime=$endTime" : ""}";
    final data = await networkClient.get(uri) as List;
    _logger.d("Candles... $data");
    return data.map((e) => Candle.fromJson(e)).toList().reversed.toList();
  }

  @override
  Future<List<SymbolResponseModel>> fetchSymbols() async {
    const uri = "https://api.binance.com/api/v3/ticker/price";
    final res = await networkClient.get(uri) as List;
    _logger.d("Symbols Response:: $res");
    final arr = res.map((e) => SymbolResponseModel.fromMap(e)).toList();

    return arr;
  }
}
