import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/chapter_hive.dart';
import 'package:meronpan/domain/entities/manga_hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:meronpan/ui/app.dart';
import 'package:window_manager/window_manager.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = Platform.isWindows
      ? await path_provider.getApplicationDocumentsDirectory()
      : await path_provider.getExternalStorageDirectory();

  print(dir!.path);

  await Hive.initFlutter(dir.path);

  Hive.registerAdapter(MangaHiveAdapter());
  Hive.registerAdapter(ChapterHiveAdapter());

  await Hive.openBox<MangaHive>('favorites');
  await Hive.openBox<ChapterHive>('chapters');
  await Hive.openBox<String>('settings');

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      // Hide window title bar
      // await windowManager.setTitleBarStyle('hidden');
      await windowManager.setMinimumSize(const Size(390, 800));
      await windowManager.setSize(const Size(412, 914));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const MeronPanApp(),
    ),
  );
}
