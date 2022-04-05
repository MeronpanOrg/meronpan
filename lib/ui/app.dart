import 'package:flutter/material.dart';

import 'package:meronpan/ui/views/views.dart';

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
        '/manga': (context) => const MangaView()
      },
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(size: 28),
        ),
      ),
    );
  }
}
