import 'package:get/get.dart';
import 'package:manifesto/features/home/domain/entities/home_entity.dart';

class HomeState extends GetXState {
  RxBool isLoading = false.obs;
  final homeData = Rxn<HomeEntity>();
}
