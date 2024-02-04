import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/homepage/ui/widgets/home_screen_body.dart';
import 'package:movieapp/features/movie%20section/cubit/fetch_now_playing_movies_cubit.dart';
import 'package:movieapp/features/movie%20section/cubit/fetch_popular_movies_cubit.dart';
import 'package:movieapp/features/trendingmovie/cubit/fetch_trending_movies_cubit.dart';
import 'package:movieapp/features/tv%20serial%20section/cubit/fetch_on_air_tvserial_cubit.dart';
import 'package:movieapp/features/tv%20serial%20section/cubit/fetch_popular_tvserial_cubit.dart';
import 'package:movieapp/features/tv%20serial%20section/cubit/fetch_top_rated_tvserial_cubit.dart';
import 'package:movieapp/features/upcoming/cubit/fetch_upcomming_movie_cubit.dart';
import 'package:movieapp/resources/movie_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchTrendingMoviesCubit(
            movieRepository: context.read<MovieRepository>(),
          )..fetchTrendingMovies(trendDay: "week"),
        ),
        BlocProvider(
            create: (context) =>
                FetchPopularMoviesCubit(movieRepository: context.read<MovieRepository>())
                  ..fetchPopularMovies(movieType: "popular")),
        BlocProvider(
            create: (context) =>
                FetchNowPlayingMoviesCubit(movieRepository: context.read<MovieRepository>())
                  ..fetchNowPlayingMovies(movieType: "now_playing")),
        BlocProvider(
          create: (context) =>
              FetchPopularTvSerialCubit(movieRepository: context.read<MovieRepository>())
                ..fetchPopularTvSerial(serialType: "popular"),
        ),
        BlocProvider(
          create: (context) =>
              FetchTopRatedTvSerialCubit(movieRepository: context.read<MovieRepository>())
                ..fetchTopRatedTvSerial(serialType: "top_rated"),
        ),
        BlocProvider(
            create: (context) =>
                FetchOnAirTvSerialCubit(movieRepository: context.read<MovieRepository>())
                  ..fetchOnAirTvSerial(serialType: "on_the_air")),
        BlocProvider(
          create: (context) =>
              FetchUpCommingMovieCubit(movieRepository:context.read<MovieRepository>())..fetchUpcommingMovies(movieType: "top_rated")
        ),
        
      ],
      child: const HomeScreenBody(),
    );
  }
}
