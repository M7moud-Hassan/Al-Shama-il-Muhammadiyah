import 'package:get/get.dart';

import 'MyController.dart';


class MyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyController>(() => MyController());
  }

}