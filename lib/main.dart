import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'utils/routes/route_names.dart';
import 'utils/routes/routes.dart';
import 'view_model/download_video_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>DownloadVideoViewModel ())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
