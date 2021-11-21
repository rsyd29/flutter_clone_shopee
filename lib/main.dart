import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Shopee Clone",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      onInit: () => Timer(
        const Duration(seconds: 5),
        () => Get.offNamed(Routes.HOME),
      ),
    ),
  );
}
