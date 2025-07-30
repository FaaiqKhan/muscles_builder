import 'dart:math';

import 'package:flutter/material.dart';
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

  static Widget loaderContainer(BuildContext context, {int? loaderValue}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.onSecondary.withAlpha(50),
      child: Image.asset(
        scale: 0.9,
        Loaders.getRandomLoadingView(value: loaderValue),
      ),
    );
  }
}
