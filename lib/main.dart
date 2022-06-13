import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tetris/gamer/gamer.dart';
import 'package:tetris/generated/lenguage.dart';
import 'package:tetris/material/audios.dart';
import 'package:tetris/panel/page_portrait.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Tetrix Retro',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
      ],
      navigatorObservers: [routeObserver],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(
        body: Sound(child: Game(child: _HomePage())),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PagePortrait();
  }
}
