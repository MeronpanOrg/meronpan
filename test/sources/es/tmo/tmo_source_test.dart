import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter_test/flutter_test.dart';
import 'package:meronpan/domain/sources/models/filter_list.dart';
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/sources/es/tmo/filters/tmo_filters.dart';
import 'package:meronpan/sources/es/tmo/providers/source/tmo_source_provider.dart';

void main() {
  final container = ProviderContainer();
  final source = container.read(tmoSourceProvider);

  late Response response;
  setUp(() async {
    response = await source.popularMangaRequest(1);
  });
  test('get html as reponsee', () {
    expect(response.requestOptions.responseType, equals(ResponseType.plain));
  });

  test(
    'Parse html to document',
    () {
      final document = parse(response.data);
      final btn = document
          .getElementsByClassName('btn btn-primary btn-block btn-lg mt-2');
      expect(btn.isNotEmpty, true);
    },
  );

  test(
    'get link,title and cover',
    () async {
      await source.popularMangaParse(response);
    },
  );

  test(
    'search berserk',
    () async {
      final mangaPages = await source.fetchSearchManga(
        1,
        'berserk',
        FilterList(
          list: [
            const TypeSelection(),
            const DemographySelection(),
            const StatusSelection(),
            const TranslationStatusSelection(),
            const FilterBySelection(),
            Sort(values: sortables, state: Direction(index: 0)),
            ContentTypeList(content: content),
            GenreList(genres: genres)
          ],
        ),
      );
      expect(mangaPages!.mangas.isNotEmpty, true);
    },
  );

  test(
    'Get populars',
    () async {
      final mangasPage = await source.fetchPopularManga(1);
      expect(mangasPage!.mangas.isNotEmpty && mangasPage.hasNextpage, true);
    },
  );
  test(
    'Get populars',
    () async {
      final mangasPage = await source.fetchPopularManga(1);
      expect(mangasPage!.mangas.isNotEmpty && mangasPage.hasNextpage, true);
    },
  );
  // test(
  //   'Get 10 populars',
  //   () async {
  //     List<MangasPage?> mangasPages = [];
  //     const oneSec = Duration(seconds: 1);
  //     await Future.forEach<int>(
  //       List<int>.generate(10, (index) => index + 1),
  //       (element) async {
  //         await Future.delayed(
  //           oneSec,
  //           () async {
  //             final mangasPage = await source.fetchPopularManga(element);
  //             mangasPages.add(mangasPage);
  //           },
  //         );
  //       },
  //     );
  //     print(mangasPages);
  //   },
  // );
  test(
    'Get manga details',
    () async {
      final manga = Manga(
          title: 'Hajimete no Sameshima-kun',
          url:
              'https://lectortmo.com/library/manga/53882/hajimete-no-sameshima-kun',
          thumbnailUrl:
              'https://otakuteca.com/images/books/cover/5f776cf4b7571.jpg');
      final res = await source.mangaDetailsRequest(manga);
      await source.mangaDetailsParse(res);
    },
  );
}
