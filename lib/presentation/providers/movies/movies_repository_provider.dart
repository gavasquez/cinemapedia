import 'package:cinemapedia/infrastructure/datasources/moviedbd_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Provider Solo lectura, es inmutable
final movieRepositryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasouce());
});
