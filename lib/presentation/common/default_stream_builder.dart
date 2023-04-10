import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultStreamBuilder<T> extends StatelessWidget {
  final Stream<Iterable<T>> stream;
  final Widget noData;
  final Widget Function(T) listItem;

  const DefaultStreamBuilder(
      {Key? key,
      required this.stream,
      required this.noData,
      required this.listItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              if (!snapshot.hasData) {
                return const Center(child: Text("No data"));
              }
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("All debts are settled"));
              }
              final data = snapshot.data!;
              if (data.isEmpty) {
                return Center(child: noData);
              }
              return Column(
                children: [
                  Container(height: 40),
                  ...data.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: listItem(e),
                    ),
                  ),
                  Container(height: 40),
                ],
              );
            }),
      ),
    );
  }
}
