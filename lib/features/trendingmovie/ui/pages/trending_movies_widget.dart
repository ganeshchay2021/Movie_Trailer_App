// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/trendingmovie/cubit/fetch_trending_movies_cubit.dart';
import 'package:movieapp/features/trendingmovie/ui/widgets/trending_movies_tiles.dart';
import 'package:movieapp/model/movie_model.dart';

class TrendingMoviesWidget extends StatelessWidget {
  const TrendingMoviesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchTrendingMoviesCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonSuccessState<List<MoviesModel>>) {
          return CarouselSlider.builder(
            itemCount: state.item.length,
            itemBuilder: ((context, index, realIndex) {
              return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: TrendingMoviesTiles(moviesModel: state.item[index]));
            }),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              viewportFraction: 1,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
