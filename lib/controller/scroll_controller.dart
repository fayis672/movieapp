import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ScrollCont extends GetxController {
  late ScrollController controller;
  // var con = RX<ScrollController>();
  var isScrollingDown = false.obs;
  //var controller = ScrollController().obs;

  @override
  void onInit() {
    addScroll();
    super.onInit();
  }

  void addScroll() {
    controller = ScrollController();
    controller.addListener(() {
      isScrollingDown.value =
          (controller.position.userScrollDirection == ScrollDirection.forward);
      update();
    });
  }
}
