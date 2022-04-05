import 'package:meronpan/core/utils/models/filter.dart';
import 'package:meronpan/sources/es/tmo/data/request/filters/genre.dart';

class GenreList extends FilterGroup<Genre> {
  final List<Genre> genres;

  const GenreList({required this.genres})
      : super(name: 'Filtrar por géneros', state: genres);

      
  GenreList copyWith({List<Genre>? genres}) {
    return GenreList(genres: genres ?? this.genres);
  }


}


List<Genre> genres = const [
  Genre(name: 'Acción', id: '1'),
  Genre(name: 'Aventura', id: '2'),
  Genre(name: 'Comedia', id: '3'),
  Genre(name: 'Drama', id: '4'),
  Genre(name: 'Recuentos de la vida', id: '5'),
  Genre(name: 'Ecchi', id: '6'),
  Genre(name: 'Fantasia', id: '7'),
  Genre(name: 'Magia', id: '8'),
  Genre(name: 'Sobrenatural', id: '9'),
  Genre(name: 'Horror', id: '10'),
  Genre(name: 'Misterio', id: '11'),
  Genre(name: 'Psicológico', id: '12'),
  Genre(name: 'Romance', id: '13'),
  Genre(name: 'Ciencia Ficción', id: '14'),
  Genre(name: 'Thriller', id: '15'),
  Genre(name: 'Deporte', id: '16'),
  Genre(name: 'Girls Love', id: '17'),
  Genre(name: 'Boys Love', id: '18'),
  Genre(name: 'Harem', id: '19'),
  Genre(name: 'Mecha', id: '20'),
  Genre(name: 'Supervivencia', id: '21'),
  Genre(name: 'Reencarnación', id: '22'),
  Genre(name: 'Gore', id: '23'),
  Genre(name: 'Apocalíptico', id: '24'),
  Genre(name: 'Tragedia', id: '25'),
  Genre(name: 'Vida Escolar', id: '26'),
  Genre(name: 'Historia', id: '27'),
  Genre(name: 'Militar', id: '28'),
  Genre(name: 'Policiaco', id: '29'),
  Genre(name: 'Crimen', id: '30'),
  Genre(name: 'Superpoderes', id: '31'),
  Genre(name: 'Vampiros', id: '32'),
  Genre(name: 'Artes Marciales', id: '33'),
  Genre(name: 'Samurái', id: '34'),
  Genre(name: 'Género Bender', id: '35'),
  Genre(name: 'Realidad Virtual', id: '36'),
  Genre(name: 'Ciberpunk', id: '37'),
  Genre(name: 'Musica', id: '38'),
  Genre(name: 'Parodia', id: '39'),
  Genre(name: 'Animación', id: '40'),
  Genre(name: 'Demonios', id: '41'),
  Genre(name: 'Familia', id: '42'),
  Genre(name: 'Extranjero', id: '43'),
  Genre(name: 'Niños', id: '44'),
  Genre(name: 'Realidad', id: '45'),
  Genre(name: 'Telenovela', id: '46'),
  Genre(name: 'Guerra', id: '47'),
  Genre(name: 'Oeste', id: '48')
];
