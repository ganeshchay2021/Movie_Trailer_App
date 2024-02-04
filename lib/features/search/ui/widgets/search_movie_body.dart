import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/homepage/ui/pages/home_screen.dart';
import 'package:movieapp/features/search/cubit/search_movie_cubit.dart';
import 'package:movieapp/features/search/ui/widgets/search_movies_tiles.dart';
import 'package:movieapp/model/movie_model.dart';
import 'package:page_transition/page_transition.dart';

class SearchMovieBody extends StatefulWidget {
  const SearchMovieBody({super.key});

  @override
  State<SearchMovieBody> createState() => _SearchMovieBodyState();
}

class _SearchMovieBodyState extends State<SearchMovieBody> {
  final TextEditingController searchtext = TextEditingController();

  List<String> searchText = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
                PageTransition(
                  child: const HomeScreen(),
                  type: PageTransitionType.topToBottom,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            iconSize: 30,
            icon: const Icon(
              FontAwesomeIcons.circleArrowLeft,
              color: Colors.white,
            )),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 15, bottom: 15, right: 10),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none),
                    autofocus: false,
                    controller: searchtext,
                    onChanged: (value) {
                      setState(() {
                        searchText.clear();
                        searchText.insert(0, value);
                      });
                      context
                          .read<SearchMovieCubit>()
                          .clearSearchResults(); // Add this line
                      context
                          .read<SearchMovieCubit>()
                          .searchMovies(searchText: searchText[0]);
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              searchtext.clear();
                              searchText.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 18.5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                searchText.isNotEmpty
                    ? NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification) {
                            FocusScope.of(context).unfocus();
                          }
                          return true;
                        },
                        child: BlocBuilder<SearchMovieCubit, CommonState>(
                            builder: (context, state) {
                          if (state is CommonSuccessState<List<MoviesModel>>) {
                            if (state.item.isEmpty) {
                              return const Text(
                                "No results found",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              );
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: state.item.length,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return SearchMoviesTiles(
                                      moviesModel: state.item[index],
                                    );
                                  },
                                ),
                              );
                            }
                          } else if (state is CommonErrorState) {
                            return const Text(
                              "No results founds",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontSize: 18),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                      )
                    : const Center(
                        child: Text(
                          "Let's Search",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
