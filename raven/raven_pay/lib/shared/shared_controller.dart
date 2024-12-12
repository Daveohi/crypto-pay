import 'package:get/get.dart';

import '../data/providers/base/base_provider.dart';
import '../data/repositories/base/base_repository.dart';
import '../data/services/network_config/network_service.dart';

mixin GlobalController {
  BaseProvider get binanceProvider => Get.find();
  BaseRepository get binanceRepository => Get.find();
  NetworkService get networkClient => Get.find();
}
