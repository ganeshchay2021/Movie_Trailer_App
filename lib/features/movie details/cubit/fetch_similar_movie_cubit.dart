// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/model/movie_model.dart';
import 'package:movieapp/resources/movie_details_repository.dart';

class FetchSimilarMovieCubit extends Cubit<CommonState> {
  final MovieDetailsRepository movieDetailsRepository;
  FetchSimilarMovieCubit({required this.movieDetailsRepository})
      : super(CommonInitialState());

      fetchSimilarMovies({required int? id, required String movieType})async{
        emit(CommonLoadingState());
        final result=await movieDetailsRepository.fetchMovies(id: id, movieType: movieType);
        result.fold((l) => emit(CommonErrorState(erroeMsg: l)), (r) => emit(CommonSuccessState<List<MoviesModel>>(item: r)));

      }


}
