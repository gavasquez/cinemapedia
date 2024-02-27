
//* abstract sirve para no crear instancias de ella
import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}