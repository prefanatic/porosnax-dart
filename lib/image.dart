import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show instantiateImageCodec, Codec;
import 'dart:ui' show Size, Locale, TextDirection, hashValues;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Fetches the given URL from the network, associating it with the given scale.
///
/// The image will be cached regardless of cache headers from the server.
///
/// This differs slightly from [NetworkImage] where a callback can be
/// provided to receive the [Uint8List] before it is processed.
///

class NetworkCalloutImage extends ImageProvider<NetworkCalloutImage> {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments must not be null.
  const NetworkCalloutImage(this.url,
      {this.scale: 1.0, this.headers, this.callback})
      : assert(url != null),
        assert(scale != null);

  /// The URL from which the image will be fetched.
  final String url;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// The HTTP headers that will be used with [HttpClient.get] to fetch image from network.
  final Map<String, String> headers;

  /// A callback for the bytes received.
  final Function(Uint8List) callback;

  @override
  Future<NetworkCalloutImage> obtainKey(ImageConfiguration configuration) {
    return new SynchronousFuture<NetworkCalloutImage>(this);
  }

  @override
  ImageStreamCompleter load(NetworkCalloutImage key) {
    return new MultiFrameImageStreamCompleter(
        codec: _loadAsync(key),
        scale: key.scale,
        informationCollector: (StringBuffer information) {
          information.writeln('Image provider: $this');
          information.write('Image key: $key');
        });
  }

  static final HttpClient _httpClient = new HttpClient();

  Future<ui.Codec> _loadAsync(NetworkCalloutImage key) async {
    assert(key == this);

    final Uri resolved = Uri.base.resolve(key.url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    headers?.forEach((String name, String value) {
      request.headers.add(name, value);
    });
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.OK)
      throw new Exception('HTTP request failed, statusCode: ${response
          ?.statusCode}, $resolved');

    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0)
      throw new Exception('NetworkImage is an empty file: $resolved');

    if (callback != null) callback(bytes);

    return await ui.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final NetworkCalloutImage typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}
