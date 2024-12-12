import 'package:get/get.dart';

import '../../../data/di/di.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerLazySingleton<HomeController>(
        () => HomeController());
  }
}
