import 'package:cinemapedia/domain/entities/movie_entity.dart';


abstract class MoviesDatasource {
  Future<List<Movie>>getnowPlaying({int page =1});
}



