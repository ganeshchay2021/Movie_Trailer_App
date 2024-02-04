// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/movie%20details/movie%20review/cubit/fetch_movie_review_cubit.dart';
import 'package:movieapp/features/movie%20details/movie%20review/model/movie_review_model.dart';
import 'package:readmore/readmore.dart';

class UserReviewWidget extends StatefulWidget {
  const UserReviewWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UserReviewWidget> createState() => _UserReviewWidgetState();
}

class _UserReviewWidgetState extends State<UserReviewWidget> {
  bool showAll = false;
    final cacheManager=CacheManager(
    Config(
      "imageCached",
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100
    )
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMovieReviewCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonSuccessState<List<MovieReviewModel>>) {
          if (state.item.isEmpty) {
            return Container(
              margin: const EdgeInsets.only(left: 10, top: 5),
              child: Row(
                children: [
                  Text(
                    "No review available",
                    style: TextStyle(fontSize: 20, color: Colors.red.shade400),
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
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: showAll
                      ? null
                      : Border.all(color: Colors.white, width: 1)),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 10, top: 10),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'User Reviews',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showAll = !showAll;
                            });
                          },
                          child: Row(
                            children: [
                              showAll == false
                                  ? Text(
                                      "All Review ${state.item.length}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text(
                                      'Show Less',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  showAll == true
                      ? Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.red,
                            width: 1,
                          )),
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.item.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  right: 20,
                                  bottom: 10,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://image.tmdb.org/t/p/w500/${state.item[index].authorDetails.avatarPath}",
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        color: Colors.black12,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Center(
                                                        child: Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        state.item[index].author
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      state.item[index].author,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "${state.item[index].authorDetails.rating}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ReadMoreText(
                                            state.item[index].content,
                                            // textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 0.9),
                                            trimLines: 4,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'Read more',
                                            moreStyle: const TextStyle(
                                                color: Colors.red),
                                            trimExpandedText: 'Read less',
                                            lessStyle: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "https://image.tmdb.org/t/p/w500/${state.item[0].authorDetails.avatarPath}",
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                state.item[0].author,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              state.item[0].authorDetails
                                                  .username,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "${state.item[0].authorDetails.rating}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.item[0].content,
                                    maxLines: 2,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            //show more button
                          ],
                        )
                ],
              ),
            );
          }
        } else if (state is CommonErrorState) {
          return Text(
            state.erroeMsg,
            style: const TextStyle(color: Colors.white),
          );
        } else {
          return const Center(
            child: SizedBox(),
          );
        }
      },
    );
  }
}
