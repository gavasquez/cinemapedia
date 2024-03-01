import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Provider
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

/* 
{
  '473838': Movie(),
  '343443': Movie(),
  '789767': Movie(),
  '234343': Movie(),
}
*/
typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    // Si no tenemos cargada la pelicula
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
