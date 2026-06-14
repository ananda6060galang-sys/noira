import 'package:get/get.dart';

class NavigationController extends GetxController {
  final selectedIndex = 0.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}
