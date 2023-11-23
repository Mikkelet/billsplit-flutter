import 'dart:ui';

import 'package:billsplit_flutter/domain/models/decimal_denominator.dart';
import 'package:billsplit_flutter/domain/models/scanned_receipt.dart';
import 'package:billsplit_flutter/domain/models/scanned_receipt_item.dart';
import 'package:billsplit_flutter/domain/use_cases/camera/scan_receipt_usecase.dart';
import 'package:billsplit_flutter/main.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

enum MenuState {
  searching,
  receipt,
  settings;
}

class ScanReceiptCubit extends BaseCubit {
  final _scanReceiptUseCase = ScanReceiptUseCase();
  late CameraController cameraController;
  ScannedReceipt? receipt;
  bool isSnappingPhoto = false;
  DecimalDenominator _decimalDenominator = DecimalDenominator.comma;
  MenuState menuState = MenuState.searching;

  void initialize() async {
    showLoading();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize();
    _getLastUsedDecimalDenominator();
    update();
  }

  void _getLastUsedDecimalDenominator() {
    final denomString = sharedPrefs.lastUsedDecimalDenominator;
    _decimalDenominator = DecimalDenominator.fromString(denomString);
  }

  void snapPhoto(Size size) {
    isSnappingPhoto = true;
    update();
    cameraController.takePicture().then((value) {
      isSnappingPhoto = false;
      update();
      _uploadReceipt(size, value);
    }).catchError((err, stackTrace) {
      isSnappingPhoto = false;
      showError(err, stackTrace);
    });
  }

  void _uploadReceipt(Size windowSize, XFile xFile) {
    showLoading();
    _scanReceiptUseCase.launch(
      windowSize,
      xFile,
      _decimalDenominator,
    ).then((scannedReceipt) {
      if (scannedReceipt.items.isEmpty) {
        showToast("No items found");
        return;
      }
      menuState = MenuState.receipt;
      receipt = scannedReceipt;
      update();
    }).catchError((onError, st) {
      menuState = MenuState.receipt;
      showError(onError, st);
    });
  }

  Future pickFromGallery(Size windowSize) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _uploadReceipt(windowSize, XFile(file.path));
    }
  }

  void cancelPicture() {
    receipt = null;
    emit(Main());
  }

  Iterable<ScannedReceiptItem> getReceiptItems(double upperBarrier,
      double lowerBarrier) {
    if (receipt == null) return [];

    // check if *inside* barriers
    return receipt!.items.where((element) =>
    element.boundaryBox.top > upperBarrier &&
        element.boundaryBox.bottom < lowerBarrier);
  }

  @override
  Future<void> close() {
    cameraController.dispose();
    return super.close();
  }

  void toggleDenominator() {
    if (_decimalDenominator == DecimalDenominator.comma) {
      _decimalDenominator = DecimalDenominator.period;
    } else {
      _decimalDenominator = DecimalDenominator.comma;
    }
    sharedPrefs.lastUsedDecimalDenominator = _decimalDenominator.displayName;
    update();
  }

  DecimalDenominator get decimalDenominator => _decimalDenominator;

  void showScannerSettings() {
    menuState = MenuState.settings;
    update();
  }

  void exitSettings() {
    menuState = MenuState.searching;
    update();
  }
}
