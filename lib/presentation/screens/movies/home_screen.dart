import 'package:cinemapedia/config/constants/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //esto es una prueba para saber si tenemos la variable de entorno en toda nuestra app solo es imprimirla
        child: Text(Enviroment
            .theMovieDbKey), //y esto viene de nuestro archivo de constnantes
      ),
    );
  }
}
