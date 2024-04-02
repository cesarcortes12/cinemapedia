


//ESTO VIENE DE LA CONVERSION EN QUICK TYPE DE LA SOLICITUD EN POSTMAN Y CONVERTIDO 

//y se modifica segun  sea como nosotros queramos es decir  datos opcionales


import 'package:cinemapedia/infrestructure/models/moviedb/movie_moviedb.dart';

class MovieDbResponse {
    final Dates? dates; //al seropcional ver validacion abajo
    final int page;
    final List<MovieMovieDB> results;
    final int totalPages;
    final int totalResults;

    MovieDbResponse({
        this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(
        dates: json["dates"] ? Dates.fromJson(json["dates"]) : null, //VALIDACION CUANDO ALGO PUEDE VENIR NULL
        page: json["page"],
        results: List<MovieMovieDB>.from(json["results"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "dates":dates  == null ? null  : dates!.toJson(), //SI ES NULO entocnes arroja UN null SINO LE ASEGURAMOS QUE VIENE CON EL !
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Dates {
    final DateTime maximum;
    final DateTime minimum;

    Dates({
        required this.maximum,
        required this.minimum,
    });

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}

