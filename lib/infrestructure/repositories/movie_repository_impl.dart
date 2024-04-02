import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';




class MovieRepositoryImpl extends MoviesRepository {
  
  final MoviesDatasource datasource; //MoviesDatasource es la clase padre

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getnowPlaying({int page = 1}) {
    return datasource.getnowPlaying(page: page);
  }
}
