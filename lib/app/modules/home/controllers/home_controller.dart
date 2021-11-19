import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// NOTE: Variable and method for bottomNavigationBar and carousel slider
  final _tabIndex = 0.obs;
  final _currentSlider = 0.obs;

  set tabIndex(val) => _tabIndex.value = val;
  set currentSlider(value) => _currentSlider.value = value;

  get tabIndex => _tabIndex.value;
  get currentSlider => _currentSlider.value;

  void changeTabIndex(int index) {
    tabIndex = index;
  }

  /// NOTE: Variable and method for qr scan
  String scannedQRCode = '';

  Future<void> scanQR() async {
    try {
      scannedQRCode = await FlutterBarcodeScanner.scanBarcode(
        '#ee4e2e',
        'Batal',
        true,
        ScanMode.QR,
      );

      Get.snackbar(
        "Result",
        "QR Code: $scannedQRCode",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xffee4e2e),
        colorText: Colors.white,
      );
    } on PlatformException {
      String resultQRCode = scannedQRCode == '-1' ? 'Batal' : 'Gagal';
      Get.snackbar(
        "Error",
        "QR Code: $resultQRCode",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xffb2b2b2),
        colorText: Colors.black,
      );
    }
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
