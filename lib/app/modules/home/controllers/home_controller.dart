import 'dart:async';

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

  /// NOTE: Create countdown timer for flash sale
  static const countdownDuration = Duration(hours: 2);
  final duration = Duration().obs;
  Rxn<Timer> timer = Rxn<Timer>();

  final _isCountdown = true.obs;
  set isCountdown(value) => this._isCountdown.value = value;
  get isCountdown => this._isCountdown.value;

  void addTime() {
    final addSeconds = _isCountdown.value ? -1 : 1;

    final seconds = duration.value.inSeconds + addSeconds;
    if (seconds < 0) {
      timer.value?.cancel();
    } else {
      duration.value = Duration(seconds: seconds);
    }
  }

  void startTimer() {
    timer.value = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    if (isCountdown) {
      duration.value = countdownDuration;
    } else {
      duration.value = Duration();
    }
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
    reset();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
