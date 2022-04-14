import 'package:flutter/material.dart';

import 'package:meronpan/presentation/views/views.dart';

class MeronPanApp extends StatelessWidget {
  const MeronPanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meron Pan',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const RootView(),
        '/manga': (context) => const MangaView(),
        '/reader': (context) => const ReaderView(),
      },
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.lightBlueAccent,
          height: 70,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
