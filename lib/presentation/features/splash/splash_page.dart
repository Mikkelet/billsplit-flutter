import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: const Center(
        child: ClipOval(
          child: Image(
            height: 200,
            width: 200,
            image: AssetImage('assets/splitsby_logo.jpg'),
          ),
        ),
      ),
    );
  }
}
