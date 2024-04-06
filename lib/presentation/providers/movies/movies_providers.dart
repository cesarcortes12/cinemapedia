import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//esto lo que hara es que cuando necesitemos ver las peliculas que se estan reproduciendo las podre consultaren este provider
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //moviesNotifier es quien lo controla y List<Movie> es la data que fluye a travez de el

//DEFINICIO NDE LOS PROVIDERS
  final fetchMoreMovies = ref
      .watch(movieRepositoryProvider)
      .getnowPlaying; //obtenemos la funcion que se encuentra en movieRepositoyProvider

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref
      .watch(movieRepositoryProvider)
      .getPopular; //ESTO ES CONOCIDO COMO UN CASO DE USO
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//esta funcion va a  permitir que MoviesNotifier para cargar mas peliculas recibe esta funcion
typedef MovieCallback = Future<List<Movie>> Function({int page});

//esta clase nos servira para varias cosas
//1. saber cualk es la pagina actual y cargar la siguiente
class MoviesNotifier extends StateNotifier<List<Movie>> {
  //Movie es el tipo de estado que va a mantener dentro de el
  int currentPage = 0; //parametro de la clase
  bool isloading =
      false; //con esta bandera vamos a evitar cargas demas en las paginas
  MovieCallback fetchMoreMovies; //parametro de la clase

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isloading) return;

    isloading = true;
    print('loading more movies');
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    //con esto regresamos un nuevo estado para que el notifier lo escuche que continee el estado anterior mas el nuevo
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isloading = false;
  }
}
