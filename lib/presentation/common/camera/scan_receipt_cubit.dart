import 'dart:ui';

import 'package:billsplit_flutter/domain/use_cases/scan_receipt_usecase2.dart';
import 'package:billsplit_flutter/main.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class ScanReceiptCubit extends BaseCubit {
  final _scanReceiptUseCase = ScanReceiptUseCase2();
  late CameraController cameraController;
  ScannedReceipt? receipt;

  void initialize() async {
    showLoading();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize();
    emit(Main());
  }

  void uploadReceipt(Size windowSize, XFile xFile) {
    showLoading();
    _scanReceiptUseCase.launch(windowSize, xFile).then((scannedReceipt) {
      if (scannedReceipt.items.isEmpty) {
        showToast("No items found");
        return;
      }
      receipt = scannedReceipt;
      emit(Main());
    }).catchError((onError, st) {
      showError(onError, st);
    });
  }

  Future updateProfilePicture() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      uploadReceipt(Size.zero, XFile(file.path));
    }
  }

  void cancelPicture() {
    receipt = null;
    emit(Main());
  }

  Iterable<ScannedReceiptItem> getReceiptItems(
      double upperBarrier, double lowerBarrier) {
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
}
