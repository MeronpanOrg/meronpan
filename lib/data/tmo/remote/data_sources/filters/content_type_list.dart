import 'package:meronpan/data/tmo/remote/data_sources/filters/content_type.dart';
import 'package:meronpan/domain/models/filter.dart';

class ContentTypeList extends FilterGroup<ContentType> {
  final List<ContentType> content;

  const ContentTypeList({required this.content})
      : super(name: 'Filtrar por tipo de contenido', state: content);

  ContentTypeList copyWith({List<ContentType>? content}) {
    return ContentTypeList(content: content ?? this.content);
  }
}

List<ContentType> content = const [
  ContentType(name: 'Webcomic', id: 'webcomic'),
  ContentType(name: 'Yonkoma', id: 'yonkoma'),
  ContentType(name: 'Amateur', id: 'amateur'),
  ContentType(name: 'Erótico', id: 'erotic'),
];
