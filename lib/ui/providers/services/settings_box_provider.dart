import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsBoxProvider = Provider<Box<String>>((ref) {
  return Hive.box('settings');
});
