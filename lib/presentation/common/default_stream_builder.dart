import 'package:flutter/material.dart';

class DefaultStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext, T) builder;

  const DefaultStreamBuilder(
      {Key? key, required this.stream, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print("snapshot error=${snapshot.error}");
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No data"));
          }
          final data = snapshot.data!;
          return builder(context, data);
        });
  }
}
