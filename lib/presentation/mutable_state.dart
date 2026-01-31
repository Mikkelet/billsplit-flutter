import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MutableValue<T> extends StatelessWidget {
  final MutableState<T> _mutableValue;
  final Stream<T> _stream;
  final Widget Function(BuildContext, T) builder;

  MutableValue({
    super.key,
    required MutableState<T> mutableValue,
    required this.builder,
  })  : _stream = mutableValue.stateStream,
        _mutableValue = mutableValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: _stream,
      initialData: _mutableValue.value,
      builder: (context, AsyncSnapshot<T> snapshot) {
        return builder(context, snapshot.requireData);
      },
    );
  }
}

class MutableText extends StatelessWidget {
  final Stream<String> _mutString;
  final TextStyle? style;
  final TextAlign? textAlign;

  MutableText({
    super.key,
    required MutableState<String> mutString,
    this.style,
    this.textAlign,
  }) : _mutString = mutString.stateStream;

  const MutableText.fromStream({
    super.key,
    required Stream<String> mutString,
    this.style,
    this.textAlign,
  }) : _mutString = mutString;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _mutString,
      initialData: "",
      builder: (context, snapshot) {
        return Text(
          snapshot.requireData,
          style: style,
          textAlign: textAlign,
        );
      },
    );
  }
}

class MutableListState<T> extends MutableState<Iterable<T>> {
  MutableListState(super.value);

  bool get isEmpty => _cached.isEmpty;

  void add(T element) {
    _cached = [..._cached, element];
    _notify();
  }

  void remove(T element) {
    final removed = _cached.where((item) => item != element);
    _cached = removed;
    _notify();
  }

  void clear() {
    _cached = [];
    _notify();
  }

  void addAll(Iterable<T> elements) {
    _cached = [..._cached, ...elements];
    _notify();
  }

  void _notify() {
    _stream.add(true);
  }

  List<T> sublist(int startIndex, int endIndex) {
    return _cached.toList().sublist(startIndex, endIndex);
  }
}

class MutableState<T> {
  T _cached;
  final BehaviorSubject<bool> _stream = BehaviorSubject.seeded(true);

  MutableState(T value) : _cached = value;

  set value(T value) {
    _cached = value;
    _stream.add(true);
  }

  T get value => _cached;

  Stream<T> get stateStream {
    return _stream.stream.map((event) {
      return _cached;
    });
  }

  Stream<T> combine<V extends MutableState>(
      V other, T Function(T, T) transform) {
    return CombineLatestStream(
        [stateStream, other.stateStream], (x) => transform(value, other.value));
  }

  @override
  String toString() {
    return "$_cached";
  }
}

extension MutableExt<T> on T {
  MutableState<T> obs() => MutableState(this);
}

extension MutableListExt<T> on Iterable<T> {
  MutableListState<T> obsList() => MutableListState(toList());
}

extension MutableValueExt<T> on MutableState<T> {
  Widget builder({
    Key? key,
    required Widget Function(BuildContext, T) builder,
  }) =>
      MutableValue<T>(
        mutableValue: this,
        builder: builder,
      );
}
