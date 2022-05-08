import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hiveProvider = Provider<Box>((ref) {
  return Hive.box('favorites');
});

