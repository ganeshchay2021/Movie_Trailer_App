// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/model/movie_model.dart';
import 'package:movieapp/resources/movie_repository.dart';

class FetchTopRatedTvSerialCubit extends Cubit<CommonState> {
  final MovieRepository movieRepository;
  FetchTopRatedTvSerialCubit(
    {required this.movieRepository}
  ) : super(CommonInitialState());

  fetchTopRatedTvSerial({required String serialType}) async {
    emit(CommonLoadingState());
    final result = await movieRepository.fetchTvSerial(serialType: serialType);
    result.fold(
      (l) => emit(CommonErrorState(erroeMsg: l)),
      (r) => emit(
        CommonSuccessState<List<MoviesModel>>(item: r),
      ),
    );
  }
}
