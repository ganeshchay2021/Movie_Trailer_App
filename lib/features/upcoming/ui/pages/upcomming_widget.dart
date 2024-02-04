import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/upcoming/cubit/fetch_upcomming_movie_cubit.dart';

import 'package:movieapp/model/movie_model.dart';
import 'package:movieapp/widgets/shows_widget.dart';

class UpCommingWidget extends StatelessWidget {
  const UpCommingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Upcomming Movies",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<FetchUpCommingMovieCubit, CommonState>(
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
