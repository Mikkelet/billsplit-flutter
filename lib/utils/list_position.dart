import 'package:flutter/material.dart';

enum ListPosition {
  single,
  first,
  middle,
  last;

  BorderRadius getBorderRadius(
      {double softCorner = 30, double hardCorner = 10}) {
    if (this == single) {
      return BorderRadius.vertical(
          top: Radius.circular(softCorner),
          bottom: Radius.circular(softCorner));
    }
    if (this == first) {
      return BorderRadius.vertical(
          top: Radius.circular(softCorner),
          bottom: Radius.circular(hardCorner));
    }
    if (this == last) {
      return BorderRadius.vertical(
          top: Radius.circular(hardCorner),
          bottom: Radius.circular(softCorner));
    }
    return BorderRadius.vertical(
        top: Radius.circular(hardCorner), bottom: Radius.circular(hardCorner));
  }

  static ListPosition calculatePosition<T>(int index, Iterable<T> list) {
    if (list.length == 1) {
      return single;
    } else if (index == 0) {
      return first;
    } else if (index == list.length - 1) {
      return last;
    }
    return middle;
  }
}
