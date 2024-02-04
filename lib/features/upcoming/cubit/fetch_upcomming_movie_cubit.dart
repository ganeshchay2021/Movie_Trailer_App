import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/constant/common_state.dart';
import 'package:movieapp/resources/movie_repository.dart';

class FetchUpCommingMovieCubit extends Cubit<CommonState> {
  final MovieRepository movieRepository;
  FetchUpCommingMovieCubit({required this.movieRepository})
      : super(CommonInitialState());

  fetchUpcommingMovies({required String movieType}) async {
    emit(CommonLoadingState());
    final result = await movieRepository.fetchMovies(movieType: movieType);
    result.fold((l) => emit(CommonErrorState(erroeMsg: l)),
        (r) => emit(CommonSuccessState(item: r)));
  }
}
