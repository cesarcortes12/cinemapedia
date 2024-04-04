import 'package:cinemapedia/infrestructure/datasources/themoviedb_datasource.dart';
import 'package:cinemapedia/infrestructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




//este repositorio es inmutalbe
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(TheMovieDbDatasource());
});
