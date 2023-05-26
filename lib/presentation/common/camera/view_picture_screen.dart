import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ViewPictureScreen extends StatelessWidget {
  final XFile xFile;

  const ViewPictureScreen(this.xFile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.file(File(xFile.path)));
  }
}
