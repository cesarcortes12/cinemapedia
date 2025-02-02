import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

//aqui lo que vamos a hacer es implementar lo que MoviesDatasource del domain me pida
class TheMovieDbDatasource extends MoviesDatasource {
  //al instalar dio vamos a crear una instancia de dio y le definimos los parametros para funcione
  //y con esto queda configurado nuestro cliente de peticiones http para themovieDb
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-ES'
      }));

  //creacion metodo para reutilizar la peticion
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getnowPlaying({int page = 1}) async {
    //ese dio ya esta configurado arriba
    //lo que recibimos de la peticion lo vamos a enviar a a nuestros modelos Modelos para extraer la informacion que nosotros
    //vamos a querer y retonarlo con la forma que queremos

    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    //como en el ´primer mapeo se obtiene informacion d ela peliculas per dentro de ese viene otra lsita de la informacion detallada
    //e cada una entonces se pas nuevamente por el otro mapper que tenemos para las peliculas

    //esto es un filtro porsi no viene poster pues no creara la pelicula
    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }
}
