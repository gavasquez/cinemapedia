//* abstract sirve para no crear instancias de ella
import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

  // Solo una pelicula
  Future<Movie> getMovieById(String id);

  // Datasource de busqueda de peliculas
  Future<List<Movie>> searchMovies(String query);
}
