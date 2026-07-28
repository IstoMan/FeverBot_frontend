import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/core/theme/theme_controller.dart';
import 'package:manifesto/common/resources/network_resources/network_info/network_info.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/clients/dio_client/dio_client.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    /// Inject dependencies common to FeverBot
    Get.lazyPut<NetworkInfo>(
      () => NetworkInfo(connectivity: Connectivity()),
      fenix: true,
    );

    Get.lazyPut<RestClient>(
      () => DioClient(networkInfo: Get.find()),
      fenix: true,
    );
  }
}
