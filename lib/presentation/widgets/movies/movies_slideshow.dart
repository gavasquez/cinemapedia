import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      //* Swiper es un paquete = card_swiper
      //* Swiper es similiar a un pageView
      child: Swiper(
        //* viewportFraction: 0.8, = para ver el slider anterior y el que sigue
        viewportFraction: 0.8,
        //* scale: 0.9 = para ponerlos mas pequeños el anterior y el que sigue
        scale: 0.9,
        //* autoplay: true = para que este siempre moviendose
        autoplay: true,
        //* Configuracion de la paginacion del swiper
        pagination: SwiperPagination(
            //* Bajar un poco la pagination
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(
            movie: movie,
          );
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              //* color de fondo
              color: Colors.black45,
              //* difuminacion  de la sombra
              blurRadius: 10,
              //* Posicion de la sombra
              offset: Offset(0, 10)),
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        //* ClipRRect permite poner borders redondeados
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.backdropPath,
              //* Para que tome todo el espacio que le estamos dando
              fit: BoxFit.cover,
              //* loadingBuilder nos ayuda a saber cuando la imagen se construyo o no
              loadingBuilder: (context, child, loadingProgress) {
                //* loadingProgress != null esta cargando
                if (loadingProgress != null) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12));
                }
                //* child = es lo que estamos mostrando, la imagen.
                //* FadeIn = animacion para que la imagen dentre con algo de suavidad
                //* FadeIn es un de la libreria = animate_do
                return FadeIn(child: child);
              },
            )),
      ),
    );
  }
}
