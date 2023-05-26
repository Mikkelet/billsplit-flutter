import 'package:billsplit_flutter/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SplitsbyCamera extends StatefulWidget {
  const SplitsbyCamera({Key? key}) : super(key: key);

  @override
  State<SplitsbyCamera> createState() => _SplitsbyCameraState();

  static Route getRoute() {
    return MaterialPageRoute(builder: (context) => const SplitsbyCamera());
  }
}

class _SplitsbyCameraState extends State<SplitsbyCamera> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: cameraController.initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                cameraController.buildPreview(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      onPressed: () {
                        cameraController.takePicture();
                      },
                      icon: const Icon(Icons.camera),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
