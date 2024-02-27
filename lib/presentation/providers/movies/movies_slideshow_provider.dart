import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* provider de solo lectura, se crea este provider para sacar una sublista que ira de 0,6
final movidesSlideshowProvider = Provider<List<Movie>>((ref) {
  // obtenemos el provider
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0, 6);
});
