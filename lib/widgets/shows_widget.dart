// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movieapp/features/movie%20details/ui/pages/movie_details_screen.dart';

import 'package:movieapp/model/movie_model.dart';
import 'package:page_transition/page_transition.dart';

class ShowsWidget extends StatefulWidget {
  const ShowsWidget({
    Key? key,
    required this.moviesModel,
  }) : super(key: key);
  final MoviesModel moviesModel;

  @override
  State<ShowsWidget> createState() => _ShowsWidgetState();
}

class _ShowsWidgetState extends State<ShowsWidget> {
    final cacheManager=CacheManager(
    Config(
      "imageCached",
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100
    )
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
                child: MovieDetailsScreen(id: widget.moviesModel.id),
                type: PageTransitionType.fade),
            (route) => route.isFirst);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.only(right: 10),
        width: 170,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    "https://image.tmdb.org/t/p/w500${widget.moviesModel.posterpath}",
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.only(top: 5, right: 5),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                    Text(
                      " ${widget.moviesModel.popularity}",
                      style:
                          TextStyle(color: Colors.grey.shade200, fontSize: 12),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
