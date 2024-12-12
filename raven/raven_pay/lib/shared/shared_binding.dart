import 'package:get/get.dart';

import '../data/di/di.dart';
import '../data/providers/base/base_provider.dart';
import '../data/providers/base/base_provider_impl.dart';
import '../data/repositories/base/base_repository.dart';
import '../data/repositories/base/base_repository_impl.dart';
import '../data/services/network_config/network_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerSingleton<BaseProvider>(
      BaseProviderImpl(),
      permanent: true,
    );

    DependencyProvider.registerSingleton<BaseRepository>(
      BaseRepositoryImpl(),
      permanent: true,
    );

    DependencyProvider.registerSingleton<NetworkService>(
      NetworkService(),
      permanent: true,
    );
  }
}
