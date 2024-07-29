import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/movie%20section/ui/pages/movie_widget.dart';
import 'package:movieapp/features/search/ui/pages/search_movie_screen.dart';
import 'package:movieapp/features/trendingmovie/cubit/fetch_trending_movies_cubit.dart';
import 'package:movieapp/features/trendingmovie/ui/pages/trending_movies_widget.dart';
import 'package:movieapp/features/tv%20serial%20section/ui/pages/tv_serial_widget.dart';
import 'package:movieapp/features/upcoming/ui/pages/upcomming_widget.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with TickerProviderStateMixin {
  int? dropvalue = 0;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Colors.black,
              centerTitle: true,
              toolbarHeight: 60,
              expandedHeight: MediaQuery.of(context).size.height * 0.42,
              flexibleSpace: Builder(
                builder: (context) {
                  return const FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: TrendingMoviesWidget(),
                  );
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Trending 🔥",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton(
                        autofocus: true,
                        underline:
                            Container(height: 0, color: Colors.transparent),
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 30,
                        ),
                        iconEnabledColor: Colors.yellow,
                        alignment: Alignment.bottomCenter,
                        dropdownColor: Colors.black,
                        value: dropvalue,
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Text(
                              "Weekly",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "Daily",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 0) {
                            context
                                .read<FetchTrendingMoviesCubit>()
                                .fetchTrendingMovies(trendDay: "week");
                          } else if (value == 1) {
                            context
                                .read<FetchTrendingMoviesCubit>()
                                .fetchTrendingMovies(trendDay: "day");
                          }
                          setState(() {
                            dropvalue = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      children: [
                        const Text(
                          "Search your movie",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: const SearchMovieScreen(),
                                type: PageTransitionType.bottomToTop,
                                duration: const Duration(milliseconds: 300),
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Search",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      unselectedLabelStyle: const TextStyle(fontSize: 14),
                      splashBorderRadius: BorderRadius.circular(12),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      physics: const BouncingScrollPhysics(),
                      labelPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber),
                      controller: tabController,
                      tabs: const [
                        Tab(
                          child: Text(
                            "Movie",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Upcoming",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "TV Serial",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 880,
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        MovieWidget(),
                        UpCommingWidget(),
                        TvSerialWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
