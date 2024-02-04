// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/movie%20details/cubit/fetch_movie_details_cubit.dart';
import 'package:movieapp/features/movie%20details/cubit/fetch_recommendations_movie_cubit.dart';
import 'package:movieapp/features/movie%20details/cubit/fetch_similar_movie_cubit.dart';
import 'package:movieapp/features/movie%20details/movie%20review/cubit/fetch_movie_review_cubit.dart';
import 'package:movieapp/features/movie%20details/trailler/cubit/fetch_movie_tailler_cubit.dart';

import 'package:movieapp/features/movie%20details/ui/widgets/movie_details_body.dart';
import 'package:movieapp/resources/movie_details_repository.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int? id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchMovieDetailsCubit(
              movieDetailsRepository: context.read<MovieDetailsRepository>())
            ..fetchMovieDetails(id: id),
        ),
        BlocProvider(
          create: (context) => FetchSimilarMovieCubit(movieDetailsRepository: context.read<MovieDetailsRepository>())..fetchSimilarMovies(id: id, movieType: "similar"),
        ),
         BlocProvider(
          create: (context) => FetchRecommendationsMovieCubit(movieDetailsRepository: context.read<MovieDetailsRepository>())..fetchRecommendedMovies(id: id, movieType: "recommendations"),
        ),
        BlocProvider(
          create: (context) => FetchMovieTraillerCubit(movieDetailsRepository: context.read<MovieDetailsRepository>())..fetchMovieTailler(id: id),
        ),
        BlocProvider(
          create: (context) => FetchMovieReviewCubit(movieDetailsRepository: context.read<MovieDetailsRepository>())..fetchMovieReview(id: id),
        ),
      ],
      child: const MovieDetailsBody(),
    );
  }
}
