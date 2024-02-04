import 'package:bloc/bloc.dart';

import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/model/movie_model.dart';
import 'package:movieapp/resources/movie_repository.dart';

class FetchTrendingMoviesCubit extends Cubit<CommonState> {
  final MovieRepository movieRepository;
  FetchTrendingMoviesCubit({required this.movieRepository})
      : super(CommonInitialState());

  fetchTrendingMovies({required String trendDay}) async {
    emit(CommonLoadingState());
    final result = await movieRepository.fetchTrendingMovies(trendDay:trendDay );
    result.fold((l) => emit(CommonErrorState(erroeMsg: l)),
        (r) => emit(CommonSuccessState<List<MoviesModel>>(item: r)));
  }
}
