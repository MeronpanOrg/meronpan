import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider(
  (ref) {
// Global options
    final cacheStore = HiveCacheStore(null);

    final options = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.refreshForceCache,
      hitCacheOnErrorExcept: [],
      maxStale: const Duration(
        days: 1,
      ), //increase number of days for loger cache
      priority: CachePriority.high,
    );

// Add cache interceptor with global/default options
    final dio = Dio()..interceptors.add(DioCacheInterceptor(options: options));

    ref.onDispose(() {
      cacheStore.close();
      dio.close();
    });

    return dio;
  },
);
