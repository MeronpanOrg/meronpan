

import 'package:meronpan/domain/repositories/http_repository.dart';

abstract class ITmoRepository implements HttpSourceRepository {
  @override
  String get name => 'TuMangaOnline';

  @override
  String get baseUrl => 'https://lectortmo.com';

  String get icon => 'https://nakamasweb.com/favicons/tumangaonline.ico';

  @override
  String get lang => 'es';

  @override
  int get versionId => 1;
}
