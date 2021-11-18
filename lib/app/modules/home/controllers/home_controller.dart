import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final _tabIndex = 0.obs;

  set tabIndex(val) => _tabIndex.value = val;

  get tabIndex => _tabIndex.value;

  void changeTabIndex(int index) {
    tabIndex = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
