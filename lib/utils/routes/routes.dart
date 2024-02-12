import 'package:flutter/material.dart';

import '../../view/download_video_view.dart';
import '../../view/home_view.dart';
import 'route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => const HomeView());
     
      case RouteNames.downloadVideo:
        if (args is String) {
          return MaterialPageRoute(
              builder: (context) => DownloadVideoView(url: args));
        } else {
          return MaterialPageRoute(
              builder: (_) => const Scaffold(
                    body: Center(
                      child: Text("No route found"),
                    ),
                  ));
        }
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("No route found"),
                  ),
                ));
    }
  }
}
