import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movieapp/features/movie%20details/ui/pages/movie_details_screen.dart';

import 'package:movieapp/model/movie_model.dart';
import 'package:page_transition/page_transition.dart';

class SearchMoviesTiles extends StatefulWidget {
  const SearchMoviesTiles({
    Key? key,
    required this.moviesModel,
  }) : super(key: key);

  final MoviesModel moviesModel;

  @override
  State<SearchMoviesTiles> createState() => _SearchMoviesTilesState();
}

class _SearchMoviesTilesState extends State<SearchMoviesTiles> {
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
        Navigator.of(context).push(PageTransition(
          child: MovieDetailsScreen(id: widget.moviesModel.id),
          type: PageTransitionType.fade,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 4, bottom: 4),
        height: 180,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(20, 20, 20, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  cacheManager: cacheManager,
                  fit: BoxFit.fill,
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500${widget.moviesModel.posterpath}",
                  placeholder: (context, url) =>
                      Container(color: Colors.black12,),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.moviesModel.originaltitle.toString(),
                              maxLines: 2,
                              style: const TextStyle(
                                overflow: TextOverflow.fade,
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(widget.moviesModel.voteaverage.toString())
                                  ]),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  const Icon(
                                    Icons.people_outline_sharp,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.moviesModel.popularity.toString())
                                ])))
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 85,
                      child: Text(
                        widget.moviesModel.overview.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            overflow: TextOverflow.clip),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
