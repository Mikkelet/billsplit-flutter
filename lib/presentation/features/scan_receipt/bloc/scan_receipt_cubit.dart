import 'dart:ui';

import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/decimal_denominator.dart';
import 'package:billsplit_flutter/domain/models/scanned_receipt.dart';
import 'package:billsplit_flutter/domain/models/scanned_receipt_item.dart';
import 'package:billsplit_flutter/domain/use_cases/camera/scan_receipt_usecase.dart';
import 'package:billsplit_flutter/main.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/bloc/scan_receipt_state.dart';
import 'package:camera/camera.dart';
import 'package:flutter/src/gestures/drag_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ScanReceiptCubit extends Cubit<ScanReceiptState> {
  final _scanReceiptUseCase = ScanReceiptUseCase();
  final sharedPrefs = getIt<SharedPrefs>();
  late CameraController cameraController;
  ScannedReceipt? receipt;

  ScanReceiptCubit() : super(const ScanReceiptState()) {
    initialize();
  }

  void initialize() async {
    try {
      emit(state.copyWith(isLoading: true));
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      await cameraController.initialize();
      _getLastUsedDecimalDenominator();
    } catch (e, st) {
      // handleError(e, st);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _getLastUsedDecimalDenominator() {
    final denomString = sharedPrefs.lastUsedDecimalDenominator;
    emit(state.copyWith(
        decimalDenominator: DecimalDenominator.fromString(denomString)));
  }

  Future<void> snapPhoto(Size size) async {
    try {
      emit(state.copyWith(isSnappingPhoto: true));
      final photo = await cameraController.takePicture();
      await _uploadReceipt(size, photo);
    } catch (e, st) {
      // handleError(e, st);
    } finally {
      emit(state.copyWith(isSnappingPhoto: false));
    }
  }

  Future<void> _uploadReceipt(Size windowSize, XFile xFile) async {
    try {
      emit(state.copyWith(isLoading: true));
      final scannedReceipt =
          await _scanReceiptUseCase.launch(windowSize, xFile);
      emit(state.copyWith(menuState: MenuState.receipt));
      receipt = scannedReceipt;
    } catch (e, st) {
      // handleError(e, st);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> pickFromGallery(Size windowSize) async {
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        await _uploadReceipt(windowSize, XFile(file.path));
      }
    } catch (e, st) {
      // handleError(e, st);
    }
  }

  void cancelPicture() {
    receipt = null;
    emit(state.copyWith(
      isSnappingPhoto: false,
      isLoading: false,
      menuState: MenuState.searching,
    ));
  }

  Iterable<ScannedReceiptItem> getReceiptItems(
      double upperBarrier, double lowerBarrier) {
    if (receipt == null) return [];

    // check if *inside* barriers
    return receipt!.items.where((element) =>
        element.boundaryBox.top > upperBarrier &&
        element.boundaryBox.bottom < lowerBarrier);
  }

  void toggleDenominator() {
    if (state.decimalDenominator == DecimalDenominator.comma) {
      emit(state.copyWith(decimalDenominator: DecimalDenominator.period));
    } else {
      emit(state.copyWith(decimalDenominator: DecimalDenominator.comma));
    }
    sharedPrefs.lastUsedDecimalDenominator =
        state.decimalDenominator.displayName;
  }

  void showScannerSettings() {
    emit(state.copyWith(menuState: MenuState.settings));
  }

  void exitSettings() {
    emit(state.copyWith(menuState: MenuState.searching));
  }

  void onVerticalDrag(DragUpdateDetails details) {
    final posY = details.localPosition.dy;
    const limit = 40;
    final isDraggingUpper =
        posY < state.upperBarrier + limit && posY > state.upperBarrier - limit;
    final isDraggingLower =
        posY > state.lowerBarrier - limit && posY < state.lowerBarrier + limit;
    if (isDraggingUpper) {
      emit(state.copyWith(barrierDrag: BarrierDrag.upper));
    } else if (isDraggingLower) {
      emit(state.copyWith(barrierDrag: BarrierDrag.lower));
    } else {
      emit(state.copyWith(barrierDrag: BarrierDrag.none));
    }
    if (state.barrierDrag == BarrierDrag.upper) {
      emit(state.copyWith(upperBarrier: posY));
    } else if (state.barrierDrag == BarrierDrag.lower) {
      emit(state.copyWith(lowerBarrier: posY));
    }
  }

  @override
  Future<void> close() {
    cameraController.dispose();
    return super.close();
  }

  void showFocusCircle(Offset offset) async {
    emit(state.copyWith(focusCircleOffset: offset));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(focusCircleOffset: Offset.zero));
  }
}
