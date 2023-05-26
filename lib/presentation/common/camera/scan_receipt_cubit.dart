import 'package:billsplit_flutter/domain/use_cases/scan_receipt_usecase2.dart';
import 'package:billsplit_flutter/main.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:camera/camera.dart';

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

  void uploadReceipt(XFile xFile) {
    showLoading();
    _scanReceiptUseCase.launch(xFile).then((scannedReceipt) {
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

  void cancelPicture() {
    receipt = null;
    emit(Main());
  }

  Iterable<ScannedReceiptItem> getReceiptItems(
      double upperBarrier, double lowerBarrier, double scaleFactor) {
    if(receipt == null) return [];
    return receipt!.items.where((element) =>
        element.boundaryBox.top * scaleFactor > upperBarrier &&
        element.boundaryBox.bottom * scaleFactor < lowerBarrier);
  }

  @override
  Future<void> close() {
    cameraController.dispose();
    return super.close();
  }
}
