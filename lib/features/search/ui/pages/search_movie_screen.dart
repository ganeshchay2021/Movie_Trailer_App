import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/search/cubit/search_movie_cubit.dart';
import 'package:movieapp/features/search/ui/widgets/search_movie_body.dart';
import 'package:movieapp/resources/movie_repository.dart';

class SearchMovieScreen extends StatelessWidget {
  const SearchMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchMovieCubit(movieRepository: context.read<MovieRepository>()),
      child: const SearchMovieBody(),
    );
  }
}
