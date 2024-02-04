// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/model/movie_model.dart';

class TrendingMoviesTiles extends StatelessWidget {
  const TrendingMoviesTiles({
    Key? key,
    required this.moviesModel,
  }) : super(key: key);

  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.fill,
            imageUrl:
                "https://image.tmdb.org/t/p/w500${moviesModel.posterpath}",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    " ${moviesModel.popularity}",
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
