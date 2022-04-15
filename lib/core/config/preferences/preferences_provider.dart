import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive/hive.dart';

final preferencesProvider =
    Provider<Box>((ref) => Hive.box(('preferences')));
