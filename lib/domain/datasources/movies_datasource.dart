//aqui definimo9s los metodos que vamos a necesitar para llamar la data

import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getnowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});
}
