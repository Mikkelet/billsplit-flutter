import 'package:billsplit_flutter/presentation/common/splitsby_camera.dart';
import 'package:flutter/material.dart';

class ScanReceiptButton extends StatelessWidget {
  const ScanReceiptButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Navigator.of(context).push(SplitsbyCamera.getRoute());
        },
        icon: const Icon(Icons.document_scanner_outlined));
  }
}
