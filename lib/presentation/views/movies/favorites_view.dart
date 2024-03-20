import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_massonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesViews extends ConsumerStatefulWidget {
  const FavoritesViews({super.key});

  @override
  FavoritesViewsState createState() => FavoritesViewsState();
}

class FavoritesViewsState extends ConsumerState<FavoritesViews> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    //ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    loadNextPage();
    super.initState();
  }

  void loadNextPage() async {
    print('peticion');
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lo hacemos asi por esto es un Map {}
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();
    final colors = Theme.of(context).colorScheme;
    if (favoritesMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_outlined,
              color: colors.primary,
              size: 60,
            ),
            Text(
              'Oh no!!',
              style: TextStyle(fontSize: 60, color: colors.primary),
            ),
            const Text(
              'No tienes peliculas favoritas',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            )
          ],
        ),
      );
    }
    return Scaffold(
        body: MovieMasonry(
      movies: favoritesMovies,
      loadNextPage: loadNextPage,
    ));
  }
}
