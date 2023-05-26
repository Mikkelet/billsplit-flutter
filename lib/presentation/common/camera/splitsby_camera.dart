import 'package:billsplit_flutter/main.dart';
import 'package:billsplit_flutter/presentation/common/camera/view_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../utils/routing_utils.dart';

class SplitsbyCamera extends StatefulWidget {
  const SplitsbyCamera({Key? key}) : super(key: key);

  @override
  State<SplitsbyCamera> createState() => _SplitsbyCameraState();

  static Route getRoute() {
    return slideUpRoute(const SplitsbyCamera());
  }
}

class _SplitsbyCameraState extends State<SplitsbyCamera> {
  late CameraController cameraController;
  bool snappingPicture = false;
  XFile? _xFile;
  Offset? focusCircleOffset;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (!cameraController.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

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
                ViewPictureScreen(_xFile!),
              if (focusCircleOffset != null)
                Positioned(
                  top: focusCircleOffset!.dy - 32,
                  left: focusCircleOffset!.dx - 32,
                  width: 64,
                  height: 64,
                  child: const Icon(Icons.circle_outlined),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (_xFile == null) _snapPicture(),
                      if (_xFile != null) _confirmPicture(),
                      if (_xFile != null) _cancelPicture()
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _snapPicture() {
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
            final response = await cameraController.takePicture();
            if (response is XFile && context.mounted) {
              setState(() {
                _xFile = response;
                snappingPicture = false;
              });
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

  Widget _confirmPicture() {
    return CircleAvatar(
      maxRadius: 32,
      child: IconButton(
          onPressed: () {
            Navigator.of(context).pop(_xFile);
          },
          color: Colors.white,
          icon: const Icon(Icons.check)),
    );
  }

  Widget _cancelPicture() {
    return CircleAvatar(
      maxRadius: 32,
      child: IconButton(
          onPressed: () {
            setState(() {
              _xFile = null;
            });
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
