
import 'package:meronpan/domain/sources/models/filter.dart';

class Genre extends FilterTriState {
  final String id;

  const Genre(
      {required String name,
      required this.id,
      triState state = triState.stateIgnore})
      : super(name: name, state: state);

  Genre copyWith({required triState state}) {
    return Genre(name: name, id: id, state: state);
  }

  Genre copy() {
    return Genre(
      name: name,
      id: id,
    );
  }
}
