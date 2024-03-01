import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[HomeView(), SizedBox(), FavoritesViews()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //* IndexedStack sirve para mantener el estado de la aplicación
        child: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
      ),
      //* BotomNavigation
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
