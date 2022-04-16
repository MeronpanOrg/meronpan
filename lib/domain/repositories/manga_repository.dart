///
/// A basic interface for creating a source repository.
/// It could be an online source, a local source, etc...
abstract class MangaSourceRepository {
  String get id;
  String get name;

// String getPreferenceKey= "source_$id"
}
