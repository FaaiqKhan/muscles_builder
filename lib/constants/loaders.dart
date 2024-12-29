import 'dart:math';

import 'package:muscles_builder/constants/globals.dart';

class Loaders {
  Loaders._();

  static List<String> loadingViews = [
    Globals.splashScreenLoading2GIF,
    Globals.splashScreenLoading3GIF,
    Globals.splashScreenLoading4GIF,
    Globals.splashScreenLoading5GIF,
    Globals.splashScreenLoading6GIF,
    Globals.splashScreenLoading7GIF,
    Globals.splashScreenLoading8GIF,
    Globals.splashScreenLoading9GIF,
  ];

  static String getRandomLoadingView({int? value}) =>
      loadingViews.elementAt(value ?? Random().nextInt(loadingViews.length));
}
