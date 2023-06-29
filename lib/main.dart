import 'package:flutter/material.dart';
import 'package:movie_app_flutter/presentation/pages/home_movie_page.dart';
import 'package:movie_app_flutter/presentation/pages/movie_detail_page.dart';
import 'package:movie_app_flutter/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app_flutter/presentation/provider/movie_list_notifier.dart';
import 'package:provider/provider.dart';

import 'package:movie_app_flutter/injection.dart' as di;
import 'common/constants.dart';
import 'common/utils.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          home: HomeMoviePage(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(builder: (_) => HomeMoviePage());
              case MovieDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
            }
          }),
    );
  }
}
