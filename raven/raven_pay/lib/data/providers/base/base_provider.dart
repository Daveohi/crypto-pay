import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/response_models/symbol_response_model.dart';

abstract class BaseProvider {
  Future<List<SymbolResponseModel>> fetchSymbols();

  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  });

  WebSocketChannel establishSocketConnection({
    required String symbol,
    required String interval,
  });
}
