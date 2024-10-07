enum FlavorType {
  development,
  production,
}

class Flavor {
  static FlavorType? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case FlavorType.development:
        return 'TaskSense';
      case FlavorType.production:
        return 'MovieMate';
      default:
        return 'title';
    }
  }
}
