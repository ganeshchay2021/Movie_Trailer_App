import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/movie%20section/cubit/fetch_now_playing_movies_cubit.dart';
import 'package:movieapp/features/movie%20section/cubit/fetch_popular_movies_cubit.dart';
import 'package:movieapp/model/movie_model.dart';

import 'package:movieapp/widgets/shows_widget.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Popular Movies",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<FetchPopularMoviesCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonSuccessState<List<MoviesModel>>) {
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.item.length,
                  itemBuilder: (context, index) {
                    return ShowsWidget(
                      moviesModel: state.item[index],
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Now Playing Movies",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<FetchNowPlayingMoviesCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonSuccessState<List<MoviesModel>>) {
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.item.length,
                  itemBuilder: (context, index) {
                    return ShowsWidget(moviesModel: state.item[index]);
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }
}
