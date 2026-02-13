import 'dart:io';

import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/bloc/scan_receipt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/bloc/scan_receipt_state.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/painter/scan_guide_painter.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/painter/text_block_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplitsbyCamera extends StatelessWidget {
  const SplitsbyCamera({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScanReceiptCubit>();
    return BlocBuilder<ScanReceiptCubit, ScanReceiptState>(
      builder: (context, state) {
        return Scaffold(
          body: Builder(
            builder: (context) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              final receipt = cubit.receipt;
              final cameraController = cubit.cameraController;
              return Center(
                child: Stack(
                  children: [
                    if (receipt == null)
                      GestureDetector(
                        child: cameraController.buildPreview(),
                        onTapDown: (details) async {
                          cubit.showFocusCircle(details.globalPosition);
                          final normalizePos = _normalizeTapPos(context, details.globalPosition);
                          await cameraController.setFocusPoint(normalizePos);
                        },
                      )
                    else
                      Image.file(File(receipt.xFile.path)),
                    if (state.focusCircleOffset != Offset.zero)
                      Positioned(
                        top: state.focusCircleOffset.dy - 32,
                        left: state.focusCircleOffset.dx - 32,
                        width: 64,
                        height: 64,
                        child: const Icon(Icons.circle_outlined),
                      ),
                    if (cubit.receipt != null)
                      GestureDetector(
                        child: CustomPaint(
                          painter: TextBlockPainter(
                            cubit.receipt!,
                            state.upperBarrier,
                            state.lowerBarrier,
                          ),
                          child: Container(),
                        ),
                        onVerticalDragUpdate: (details) {
                          cubit.onVerticalDrag(details);
                        },
                      )
                    else
                      CustomPaint(
                        painter: ScanGuidePainter(state.decimalDenominator),
                        size: MediaQuery.of(context).size,
                      ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
                          child: CloseButton(color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                    if (state.menuState == MenuState.searching)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _pickFromGallery(context),
                              _snapPicture(context),
                              _scanningSettingsButton(context),
                            ],
                          ),
                        ),
                      ),
                    if (state.menuState == MenuState.settings)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _decimalDenominatorToggle(context),
                              CircleAvatar(
                                child: BackButton(
                                  onPressed: () {
                                    cubit.exitSettings();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (state.menuState == MenuState.receipt)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (receipt != null) _cancelPicture(context),
                              if (receipt != null) _confirmPicture(context),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _snapPicture(BuildContext context) {
    final cubit = context.read<ScanReceiptCubit>();
    if (cubit.state.isSnappingPhoto) {
      return const CircularProgressIndicator();
    }
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
      maxRadius: 32,
      child: IconButton(
        onPressed: () async {
          final windowSize = MediaQuery.of(context).size;
          cubit.snapPhoto(windowSize);
        },
        iconSize: 32,
        icon: const Icon(Icons.camera),
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _scanningSettingsButton(BuildContext context) {
    final cubit = context.read<ScanReceiptCubit>();
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
      maxRadius: 32,
      child: IconButton(
        onPressed: () async {
          cubit.showScannerSettings();
        },
        iconSize: 32,
        icon: const Icon(Icons.settings),
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _decimalDenominatorToggle(BuildContext context) {
    final cubit = context.read<ScanReceiptCubit>();
    final state = cubit.state;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Decimal separator"),
        SimpleButton(
          color: Theme.of(context).colorScheme.surface.withAlpha(200),
          textColor: Theme.of(context).colorScheme.onSurface,
          height: 64,
          onClick: () {
            cubit.toggleDenominator();
          },
          child: Text(
            "${state.decimalDenominator.displayName} ${state.decimalDenominator.decimal}",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  Widget _pickFromGallery(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    final cubit = context.read<ScanReceiptCubit>();
    return CircleAvatar(
      maxRadius: 32,
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
      child: IconButton(
        onPressed: () {
          cubit.pickFromGallery(windowSize);
        },
        color: Theme.of(context).colorScheme.onSurface,
        icon: const Icon(Icons.photo_library_outlined),
      ),
    );
  }

  Widget _confirmPicture(BuildContext context) {
    final cubit = context.read<ScanReceiptCubit>();
    final state = context.read<ScanReceiptCubit>().state;
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
      maxRadius: 32,
      child: IconButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pop(cubit.getReceiptItems(state.upperBarrier, state.lowerBarrier).toList());
        },
        color: Theme.of(context).colorScheme.onSurface,
        icon: const Icon(Icons.check),
      ),
    );
  }

  Widget _cancelPicture(BuildContext context) {
    final cubit = context.read<ScanReceiptCubit>();
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
      maxRadius: 32,
      child: IconButton(
        onPressed: () {
          cubit.cancelPicture();
        },
        color: Theme.of(context).colorScheme.onSurface,
        icon: const Icon(Icons.rotate_right),
      ),
    );
  }

  Offset _normalizeTapPos(BuildContext context, Offset offset) {
    final screenSize = MediaQuery.of(context).size;
    final offsetX = offset.dx / screenSize.width;
    final offsetY = offset.dy / screenSize.height;
    return Offset(offsetX, offsetY);
  }
}
