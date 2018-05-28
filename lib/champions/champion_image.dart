import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class ChampionImagePainter extends CustomPainter {
  final Function(Uint8List) callback;
  final Image image;

  //final Offset offset = const FractionalOffset(0.0, 0.16);
  final Offset offset = const Offset(0.0, 0.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, offset, new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  static final HttpClient _httpClient = new HttpClient();

  Future<Codec> _loadAsync(String url) async {
    final Uri resolved = Uri.base.resolve(url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.OK)
      throw new Exception('HTTP request failed, statusCode: ${response
          ?.statusCode}, $resolved');

    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0)
      throw new Exception('NetworkImage is an empty file: $resolved');

    if (callback != null) callback(bytes);

    return await instantiateImageCodec(bytes);
  }
}
