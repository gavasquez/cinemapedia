import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final aapRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        //* Obtenemos el parametro page
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(
          pageIndex: pageIndex,
        );
      },
      //* Rutas Hijas
      routes: [
        //* Ruta con parametro
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            //* Obtener el id de los parametros
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        )
      ]),
  GoRoute(
    path: '/',
    redirect: (context, state) {
      return '/home/0';
    },
  )
]);
