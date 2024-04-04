import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//esto lo que hara es que cuando necesitemos ver las peliculas que se estan reproduciendo las podre consultaren este provider
final nowPlayingMoviesProvider =StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //moviesNotifier es quien lo controla y List<Movie> es la data que fluye a travez de el

  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getnowPlaying; //obtenemos la funcion que se encuentra en movieRepositoyProvider

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//esta funcion va a  permitir que MoviesNotifier para cargar mas peliculas recibe esta funcion
typedef MovieCallback = Future<List<Movie>> Function({int page});

//esta clase nos servira para varias cosas
//1. saber cualk es la pagina actual y cargar la siguiente
class MoviesNotifier extends StateNotifier<List<Movie>> {
  //Movie es el tipo de estado que va a mantener dentro de el
  int currentPage = 0; //parametro de la clase
  MovieCallback fetchMoreMovies; //parametro de la clase

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    //con esto regresamos un nuevo estado para que el notifier lo escuche que continee el estado anterior mas el nuevo
    state = [...state, ...movies];
  }
}
