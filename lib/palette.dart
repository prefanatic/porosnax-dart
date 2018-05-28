import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';

class Palette {
  static final Palette instance = const Palette._();
  static const _platform = const MethodChannel("channel.palette");

  const Palette._();

  Future<Color> generate(Uint8List bytes) async {
    Map args = {
      "data": bytes,
    };

    int color = await _platform.invokeMethod("generate", args);
    return new Color(color);
  }
}
