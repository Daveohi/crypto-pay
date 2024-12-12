import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../shared/shared_controller.dart';
import '../../models/response_models/symbol_response_model.dart';
import 'base_repository.dart';

class BaseRepositoryImpl with GlobalController implements BaseRepository {
  @override
  WebSocketChannel establishSocketConnection({
    required String symbol,
    required String interval,
  }) {
    return binanceProvider.establishSocketConnection(
      symbol: symbol,
      interval: interval,
    );
  }

  @override
  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    return binanceProvider.fetchCandles(
      symbol: symbol,
      interval: interval,
    );
  }

  @override
  Future<List<SymbolResponseModel>> fetchSymbols() async {
    return binanceProvider.fetchSymbols();
  }
}
