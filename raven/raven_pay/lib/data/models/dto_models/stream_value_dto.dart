import '../response_models/symbol_response_model.dart';

class StreamValueDTO {
  StreamValueDTO({
    required this.symbol,
    required this.interval,
  });
  late SymbolResponseModel symbol;
  late String? interval;
}
