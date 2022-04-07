
import 'package:meronpan/domain/sources/models/filter.dart';

class ContentType extends FilterTriState {
  final String id;
  const ContentType(
      {required String name,
      required this.id,
      triState state = triState.stateIgnore})
      : super(name: name, state: state);

  ContentType copyWith({required triState state}) {
    return ContentType(name: name, id: id, state: state);
  }

  ContentType copy() {
    return ContentType(
      name: name,
      id: id,
    );
  }
}
