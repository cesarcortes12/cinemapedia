import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helppers/text_formater.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class MovieHorizontallistView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontallistView(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontallistView> createState() =>
      _MovieHorizontallistViewState();
}

class _MovieHorizontallistViewState extends State<MovieHorizontallistView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(children: [
        if (widget.title != null || widget.subtitle != null)
          _Title(title: widget.title, subTitle: widget.subtitle),
        Expanded(
            child: ListView.builder(
                itemCount: widget.movies.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _Slide(movie: widget.movies[index]);
                }))
      ]),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!)),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //widget para el poster
          SizedBox(
            width: 150,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Center(
                          child: CircularProgressIndicator(strokeWidth: 2));
                    }
                    return FadeInDown(child: child);
                  },
                )),
          ),

          SizedBox(height: 5), // solo para espaciar

          //widget para el titulo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          //widget ratting
          Row(children: [
            Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
            SizedBox(width: 5),
            Text(TextFormatter.textReadableNumber(movie.voteAverage),
                style: textStyle.bodyMedium),
            SizedBox(width: 10),
            Text(TextFormatter.textReadableNumber(movie.popularity),
                style: textStyle.bodyMedium),
          ])
        ],
      ),
    );
  }
}
