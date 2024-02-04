// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/movie%20details/movie%20review/model/movie_review_model.dart';
import 'package:movieapp/resources/movie_details_repository.dart';

class FetchMovieReviewCubit extends Cubit<CommonState> {
  final MovieDetailsRepository movieDetailsRepository;
  FetchMovieReviewCubit(
    {required this.movieDetailsRepository}
  ) : super(CommonInitialState());

  fetchMovieReview({required int? id})async{
    emit(CommonLoadingState());
    final result = await movieDetailsRepository.fetchMovieReview(id: id);
    result.fold((l) => emit(CommonErrorState(erroeMsg: l)), (r) => emit(CommonSuccessState<List<MovieReviewModel>>(item: r)));
  }


}
