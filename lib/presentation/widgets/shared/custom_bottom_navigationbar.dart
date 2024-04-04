import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home_max), label: 'Categorias'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_outlined), label: 'Favoritos'),
      ],
      elevation: 0,
    );
  }
}
