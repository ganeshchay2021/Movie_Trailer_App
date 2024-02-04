import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/homepage/ui/pages/home_screen.dart';
import 'package:movieapp/features/movie%20details/cubit/fetch_movie_details_cubit.dart';
import 'package:movieapp/features/movie%20details/cubit/fetch_recommendations_movie_cubit.dart';
import 'package:movieapp/features/movie%20details/cubit/fetch_similar_movie_cubit.dart';
import 'package:movieapp/features/movie%20details/model/movie_details_model.dart';
import 'package:movieapp/features/movie%20details/movie%20review/ui/pages/review_widget.dart';
import 'package:movieapp/features/movie%20details/trailler/cubit/fetch_movie_tailler_cubit.dart';
import 'package:movieapp/features/movie%20details/trailler/model/trailler_model.dart';
import 'package:movieapp/features/movie%20details/trailler/ui/widget/trailler_widget.dart';
import 'package:movieapp/model/movie_model.dart';
import 'package:movieapp/widgets/shows_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsBody extends StatelessWidget {
  const MovieDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  FontAwesomeIcons.circleArrowLeft,
                ),
                iconSize: 25,
                color: Colors.white,
              ), 
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                      PageTransition(
                          child: const HomeScreen(),
                          type: PageTransitionType.fade),
                    );
                  },
                  icon: const Icon(Icons.home),
                  iconSize: 25,
                  color: Colors.white,
                )
              ],
              centerTitle: false,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: BlocBuilder<FetchMovieTraillerCubit, CommonState>(
                  builder: (context, state) {
                    if (state is CommonSuccessState<List<TraillerModel>>) {
                      if (state.item.isEmpty) {
                        return Center(
                          child: Text(
                            "Trailer availabe soon !!",
                            style: TextStyle(
                                color: Colors.red.shade400,
                                fontSize: 20,
                                letterSpacing: 1),
                          ),
                        );
                      } else {
                        return TraillerWidget(
                          traillerId: state.item[0].key!,
                        );
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocBuilder<FetchMovieDetailsCubit, CommonState>(
                    builder: (context, state) {
                      if (state is CommonSuccessState<MovieDetailsModel>) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    itemCount: state.item.genres.length,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        alignment: Alignment.center,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                25, 25, 25, 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          state.item.genres[index].name,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(25, 25, 25, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                state.item.originalTitle.toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 140, 255),
                                    fontSize: 20),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(25, 25, 25, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "${state.item.runtime.toString()} minutes",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(25, 25, 25, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                "Movie Story:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: ReadMoreText(
                                state.item.overview,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.9),
                                trimLines: 4,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                moreStyle: const TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                                trimExpandedText: 'Show less',
                                lessStyle: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const UserReviewWidget(),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.item.adult == false)
                                    const Text(
                                      "Rating: B",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  if (state.item.adult == true)
                                    const Text(
                                      "Rating: A",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Released Date: ${state.item.releaseDate}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Budget: \$${state.item.budget.toString()}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Revenue \$${state.item.revenue.toString()}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, bottom: 5),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(25, 25, 25, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                "Similar Movies:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            BlocBuilder<FetchSimilarMovieCubit, CommonState>(
                              builder: (context, state) {
                                if (state
                                    is CommonSuccessState<List<MoviesModel>>) {
                                  if (state.item.isEmpty) {
                                    return Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "no similar movies avialable",
                                            style: TextStyle(
                                                color: Colors.red.shade400,
                                                letterSpacing: 1),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.error,
                                            color: Colors.amber,
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 250,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.item.length,
                                        itemBuilder: (context, index) {
                                          return ShowsWidget(
                                              moviesModel: state.item[index]);
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, bottom: 5),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(25, 25, 25, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                "Recomended Movies",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            BlocBuilder<FetchRecommendationsMovieCubit,
                                CommonState>(
                              builder: (context, state) {
                                if (state
                                    is CommonSuccessState<List<MoviesModel>>) {
                                  if (state.item.isEmpty) {
                                    return Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "no recomended movies avialable",
                                            style: TextStyle(
                                                color: Colors.red.shade400,
                                                letterSpacing: 1),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.error,
                                            color: Colors.amber,
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 250,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.item.length,
                                        itemBuilder: (context, index) {
                                          return ShowsWidget(
                                              moviesModel: state.item[index]);
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      } else if (state is CommonErrorState) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/error.png",
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                "Error Loading Page !",
                                style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 28,
                                    letterSpacing: 1),
                              ),
                              const Divider(
                                color: Colors.white,
                                height: 10,
                                thickness: 1,
                              ),
                              const Text("Currently No any data availabe.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 1)),
                            ],
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
              ),
            ),
          ]),
        ));
  }
}
