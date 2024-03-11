import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class BusLoader {
  static Future<List<Rect>> readBusCollisionMap() async {
    final collidableRects = <Rect>[];
    final dynamic collisionMap = json.decode(
        await rootBundle.loadString('bus_collision.json'));

    for (final dynamic data in collisionMap['objects']) {
      collidableRects.add(Rect.fromLTWH(
          data['x'] as double,
          data['y'] as double,
          data['width'] as double,
          data['height'] as double));
    }

    return collidableRects;
  }
}
