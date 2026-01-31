import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ViewPictureScreen extends StatelessWidget {
  final XFile xFile;

  const ViewPictureScreen(this.xFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.file(File(xFile.path));
  }
}