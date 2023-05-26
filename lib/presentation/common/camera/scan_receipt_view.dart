import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/camera/scan_receipt_cubit.dart';
import 'package:billsplit_flutter/presentation/common/camera/text_block_painter.dart';
import 'package:billsplit_flutter/presentation/common/camera/view_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../utils/routing_utils.dart';

enum BarrierDrag {
  upper,
  lower,
  none;
}

class SplitsbyCamera extends StatefulWidget {
  const SplitsbyCamera({Key? key}) : super(key: key);

  @override
  State<SplitsbyCamera> createState() => _SplitsbyCameraState();

  static Route getRoute() {
    return slideUpRoute(const SplitsbyCamera());
  }
}

class _SplitsbyCameraState extends State<SplitsbyCamera> {
  bool snappingPicture = false;
  XFile? _xFile;
  Offset? focusCircleOffset;
  BarrierDrag barrierDrag = BarrierDrag.none;
  double upperBarrier = 100;
  double lowerBarrier = 500;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => ScanReceiptCubit()..initialize(),
      child: BaseBlocBuilder<ScanReceiptCubit>(
        builder: (cubit, state) => Scaffold(
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            final cameraController = cubit.cameraController;
            return Center(
              child: Stack(
                children: [
                  if (_xFile == null)
                    GestureDetector(
                      child: cameraController.buildPreview(),
                      onTapDown: (details) async {
                        _showFocusCircle(details.globalPosition);
                        final normalizePos =
                            _normalizeTapPos(context, details.globalPosition);
                        await cameraController.setFocusPoint(normalizePos);
                      },
                    )
                  else
                    GestureDetector(
                      child: ViewPictureScreen(_xFile!),
                      onVerticalDragUpdate: (details) {
                        final posY = details.globalPosition.dy;
                        const limit = 10;
                        final isDraggingUpper = posY < upperBarrier + limit &&
                            posY > upperBarrier - limit;
                        final isDraggingLower = posY > lowerBarrier - limit &&
                            posY < lowerBarrier + limit;
                        if (isDraggingUpper) {
                          barrierDrag = BarrierDrag.upper;
                        } else if (isDraggingLower) {
                          barrierDrag = BarrierDrag.lower;
                        } else {
                          barrierDrag = BarrierDrag.none;
                        }
                        if (barrierDrag == BarrierDrag.upper) {
                          setState(() {
                            upperBarrier = posY;
                          });
                        } else if (barrierDrag == BarrierDrag.lower) {
                          setState(() {
                            lowerBarrier = posY;
                          });
                        }
                      },
                    ),
                  if (focusCircleOffset != null)
                    Positioned(
                      top: focusCircleOffset!.dy - 32,
                      left: focusCircleOffset!.dx - 32,
                      width: 64,
                      height: 64,
                      child: const Icon(Icons.circle_outlined),
                    ),
                  if (cubit.xFile != null)
                    CustomPaint(
                      painter: TextBlockPainter(
                          cubit.getReceiptItems(upperBarrier, lowerBarrier),
                          upperBarrier,
                          lowerBarrier),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (_xFile == null) _snapPicture(cubit),
                          if (_xFile != null) _confirmPicture(cubit),
                          if (_xFile != null) _cancelPicture(cubit)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _snapPicture(ScanReceiptCubit cubit) {
    if (snappingPicture == true) {
      return const CircularProgressIndicator();
    }
    return CircleAvatar(
      backgroundColor: Colors.black.withAlpha(100),
      maxRadius: 32,
      child: IconButton(
        onPressed: () async {
          setState(() {
            snappingPicture = true;
          });
          try {
            final response = await cubit.cameraController.takePicture();
            if (response is XFile && context.mounted) {
              setState(() {
                _xFile = response;
                snappingPicture = false;
              });
              cubit.uploadReceipt(response);
            }
          } catch (e, st) {
            print(e);
            print(st);
          }
        },
        iconSize: 32,
        icon: const Icon(Icons.camera),
        color: Colors.white,
      ),
    );
  }

  Widget _confirmPicture(ScanReceiptCubit cubit) {
    return CircleAvatar(
      maxRadius: 32,
      child: IconButton(
          onPressed: () {
            Navigator.of(context).pop(
                cubit.getReceiptItems(upperBarrier, lowerBarrier).toList());
          },
          color: Colors.white,
          icon: const Icon(Icons.check)),
    );
  }

  Widget _cancelPicture(ScanReceiptCubit cubit) {
    return CircleAvatar(
      maxRadius: 32,
      child: IconButton(
          onPressed: () {
            cubit.cancelPicture();
          },
          color: Colors.white,
          icon: const Icon(Icons.rotate_right)),
    );
  }

  Future _showFocusCircle(Offset offset) async {
    setState(() {
      focusCircleOffset = offset;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      focusCircleOffset = null;
    });
  }

  Offset _normalizeTapPos(BuildContext context, Offset offset) {
    final screenSize = MediaQuery.of(context).size;
    final offsetX = offset.dx / screenSize.width;
    final offsetY = offset.dy / screenSize.height;
    return Offset(offsetX, offsetY);
  }
}
