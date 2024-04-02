import 'package:cinemapedia/domain/entities/movie_entity.dart';


abstract class MoviesRepository {
  Future<List<Movie>>getnowPlaying({int page =1});
}



