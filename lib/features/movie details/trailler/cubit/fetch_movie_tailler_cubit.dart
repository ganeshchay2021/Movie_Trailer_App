// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/features/movie%20details/trailler/model/trailler_model.dart';
import 'package:movieapp/resources/movie_details_repository.dart';

class FetchMovieTraillerCubit extends Cubit<CommonState> {
  final MovieDetailsRepository movieDetailsRepository;
  FetchMovieTraillerCubit({required this.movieDetailsRepository})
      : super(CommonInitialState());

  fetchMovieTailler({required int? id}) async {
    emit(CommonLoadingState());
    final result = await movieDetailsRepository.fetchMovieTrailler(id: id);
    result.fold((l) => emit(CommonErrorState(erroeMsg: l)),
        (r) => emit(CommonSuccessState<List<TraillerModel>>(item: r)));
  }
}
