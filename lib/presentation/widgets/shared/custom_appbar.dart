import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/providers/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final isDarkMode = ref.watch(themeNotifierProvider).isDark;

    return SafeArea(
      bottom: false,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Cinemapedia',
                  style: titleStyle,
                ),
                //* Spacer = sirve para tomar todo el espacio posible y va a correr los widgets
                const Spacer(),
                //* Boton del tema
                IconButton(
                    onPressed: () {
                      ref.read(themeNotifierProvider.notifier).toggleDarkMode();
                    },
                    icon: isDarkMode
                        ? const Icon(Icons.light_mode_outlined)
                        : const Icon(Icons.dark_mode_outlined)),
                //* Boton de la busqueda
                IconButton(
                    onPressed: () {
                      //* Tomamos la busqueda
                      final searchedMovies = ref.read(searchedMoviesProvider);
                      final searchQuery = ref.read(searchQueryProvider);
                      showSearch<Movie?>(
                              //* query de la busqueda
                              query: searchQuery,
                              context: context,
                              delegate: SearchMovieDelegate(
                                  initialMovies: searchedMovies,
                                  //* Solo enviamos la referencia a la funcion
                                  searchMoviesCallback: ref
                                      .read(searchedMoviesProvider.notifier)
                                      .searchMoviesQuery
                                  /*   (query) { */
                                  //* se pone la referencia a guardar del provider
                                  /* ref
                                .read(searchQueryProvider.notifier)
                                .update((state) => query);
                            return searchMovie.searchMovies(query); */
                                  ))
                          .then((movie) {
                        if (movie != null) {
                          context.push('/home/0/movie/${movie.id}');
                        }
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          )),
    );
  }
}
