import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      //* BotomNavigation
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    //* Se pone el .notifier porque no queremos el estado, queremos el notifier
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upConmingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    //* se pone watch porque si necesitamos estar pendientes del estado que nos proporciona nowPlayingMoviesProvider
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(movidesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upConmingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    //* SingleChildScrollView o CustomScrollView poder hacer scroll y no salga error que se desvordo de la pantalla
    return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        //* slivers es un widget que trabaja directamente con el scrolview
        slivers: [
          //* Ahora este es el appBar
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // appBar
              title: CustomAppbar(),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                //* appBar
                //const CustomAppbar(),
                MoviesSlideshow(movies: slideShowMovies),
                //* En cines
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  label: 'En Cines',
                  subLabel: 'Lunes 20',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: upComingMovies,
                  label: 'Próximamente',
                  subLabel: 'En este mes',
                  loadNextPage: () =>
                      ref.read(upConmingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  label: 'Lo mas Valorado',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(
                  height: 10,
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  label: 'Populares',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(
                  height: 10,
                )
                //* Expanded dado el padre expanda todo lo posible
                //Expanded(
                //  child: ListView.builder(
                //    physics: const BouncingScrollPhysics(),
                //    itemBuilder: (context, index) {
                //      final movie = nowPlayingMovies[index];
                //      return ListTile(
                //        title: Text(movie.title),
                //      );
                //    },
                //    itemCount: nowPlayingMovies.length,
                //  ),
                //)
              ],
            );
          }, childCount: 1))
        ]);
  }
}
