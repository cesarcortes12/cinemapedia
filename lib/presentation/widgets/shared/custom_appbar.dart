import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    //estilos personalizados
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              SizedBox(width: 10),
              Text('Cinemapedia', style: titleStyle),
              Spacer(), //toma el espacio disponible entre dos widgets
              IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
