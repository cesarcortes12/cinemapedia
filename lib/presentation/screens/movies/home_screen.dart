
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
    // TODO: implement initState
    super.initState();
    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); //con esto ya tenemos acceso al estado global
  }

//vamos a renderizar la data
  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    final slideShowMoovies = ref.watch(moviesSlideshowProvider);

    return Column(
      children: [
        CustomAppbar(),
        MoviesSlideshow(movies: slideShowMoovies),
        MovieHorizontallistView(
          movies: nowPlayingMovies,
          title: 'En cines',
          subtitle: 'lunes 20',
          )
      ],
    );
  }
}
