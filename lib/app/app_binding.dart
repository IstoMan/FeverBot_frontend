import 'package:get/get.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:manifesto/common/resources/network_resources/network_info/network_info.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/clients/dio_client/dio_client.dart';
import 'package:manifesto/common/core/theme/theme_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    ///TODO: inject the dependencies that are common to manifesto
    Get.lazyPut<NetworkInfo>(
      () => NetworkInfo(connectivity: Connectivity()),
    );

    Get.lazyPut<RestClient>(
      () => DioClient(networkInfo: Get.find()),
    );

    // Register theme controller
    Get.put(ThemeController(), permanent: true);
  }
}
