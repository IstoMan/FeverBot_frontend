import 'package:get/get.dart';
import 'package:manifesto/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:manifesto/features/dashboard/data/datasources/remote/dashboard_remote_datasource.dart';
import 'package:manifesto/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:manifesto/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:manifesto/features/dashboard/presentation/states/dashboard_state.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(Get.find()),
    );
    Get.lazyPut<DashboardLocalDataSource>(
      () => DashboardLocalDataSourceImpl(),
    );
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepositoryImpl(
        remoteDataSource: Get.find(),
        localDataSource: Get.find(),
      ),
    );
    Get.lazyPut<GetDashboardUseCase>(
      () => GetDashboardUseCase(Get.find()),
    );
    Get.lazyPut<DashboardState>(() => DashboardState());
    Get.lazyPut<DashboardController>(
        () => DashboardController(state: Get.find<DashboardState>()));
  }
}
