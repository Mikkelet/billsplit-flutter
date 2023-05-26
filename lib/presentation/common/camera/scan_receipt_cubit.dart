
import 'package:billsplit_flutter/domain/use_cases/scan_receipt_usecase2.dart';
import 'package:billsplit_flutter/main.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:camera/camera.dart';

class ScanReceiptCubit extends BaseCubit {
  late CameraController cameraController;
  final _scanReceiptUseCase = ScanReceiptUseCase2();
  XFile? xFile;
  Iterable<ScannedReceiptItem> scannedReceiptItems = [];

  void initialize() async {
    showLoading();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize();
    emit(Main());
  }

  void uploadReceipt(XFile xFile) {
    this.xFile = xFile;
    showLoading();
    _scanReceiptUseCase.launch(xFile).then((scannedItems) {
      if (scannedItems.isEmpty) {
        showToast("No items found");
        return;
      }
      scannedReceiptItems = scannedItems;
      emit(Main());
    }).catchError((onError, st) {
      showError(onError, st);
    });
  }

  void cancelPicture() {
    xFile = null;
    scannedReceiptItems = [];
    emit(Main());
  }

  Iterable<ScannedReceiptItem> getReceiptItems(
      double upperBarrier, double lowerBarrier) {
    return scannedReceiptItems.where((element) =>
        element.boundaryBox.top * 0.19 > upperBarrier &&
        element.boundaryBox.bottom * 0.19 < lowerBarrier);
  }

  @override
  Future<void> close() {
    cameraController.dispose();
    return super.close();
  }
}
