import 'dart:ffi';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

//widgets definidos a partir de aqui

class _HomeView extends ConsumerStatefulWidget {
  //ahora ya es un consumerstatefulwidget porque va ligado al state
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  //extiende del ConsumerState

  @override
  void initState() {
    super.initState();
    //hacemos los llamados a los  porviders
    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); //con esto ya tenemos acceso al estado global
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

//vamos a renderizar la data
  @override
  Widget build(BuildContext context) {
    //estos son los llamados
    final slideShowMoovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            //CustomAppbar(),
            MoviesSlideshow(movies: slideShowMoovies),
            MovieHorizontallistView(
                movies: nowPlayingMovies,
                title: 'En cines',
                subtitle: 'lunes 20',
                loadNextPage: () {
                  //el read se hace cuando estemos dentro de callbacks o funciones
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                }),
            MovieHorizontallistView(
                movies: popularMovies,
                title: 'Populares',
                //subtitle: 'lunes 20',
                loadNextPage: () {
                  //el read se hace cuando estemos dentro de callbacks o funciones
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                }),
            MovieHorizontallistView(
                movies: topRatedMovies,
                title: 'Top Rated',
                subtitle: 'Desde Siempre',
                loadNextPage: () {
                  //el read se hace cuando estemos dentro de callbacks o funciones
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                }),

            MovieHorizontallistView(
                movies: upcomingMovies,
                title: 'Upcoming',
                subtitle: 'Soon',
                loadNextPage: () {
                  //el read se hace cuando estemos dentro de callbacks o funciones
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                }),
            SizedBox(
              height: 20,
            ),
          ],
        );
      }))
    ]);
  }
}
