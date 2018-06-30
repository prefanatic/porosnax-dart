import 'package:flutter/material.dart';

class PaletteCache extends InheritedWidget {
  final PaletteCacheService cacheService;

  PaletteCache({this.cacheService, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return (oldWidget as PaletteCache).cacheService._cache.hashCode !=
        cacheService.hashCode;
  }

  static PaletteCacheService of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PaletteCache) as PaletteCache)
        .cacheService;
  }
}

class PaletteCacheService {
  static PaletteCacheService instance = new PaletteCacheService();

  final Map<String, Color> _cache = new Map();

  Color get(String key) => _cache[key];

  put(String key, Color color) {
    _cache[key] = color;
  }
}
