import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/tv%20serial%20section/cubit/fetch_on_air_tvserial_cubit.dart';
import 'package:movieapp/features/tv%20serial%20section/cubit/fetch_popular_tvserial_cubit.dart';
import 'package:movieapp/features/tv%20serial%20section/cubit/fetch_top_rated_tvserial_cubit.dart';
import 'package:movieapp/model/movie_model.dart';
import 'package:movieapp/widgets/shows_widget.dart';

class TvSerialWidget extends StatelessWidget {
  const TvSerialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Popular Serials",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<FetchPopularTvSerialCubit, CommonState>(
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
          "Top Rated Serials",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<FetchTopRatedTvSerialCubit, CommonState>(
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
          "On Air Tv Serials",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<FetchOnAirTvSerialCubit, CommonState>(
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
      ],
    );
  }
}
