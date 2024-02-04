import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movieapp/constant/api_key.dart';
import 'package:movieapp/features/movie%20details/model/movie_details_model.dart';
import 'package:movieapp/features/movie%20details/movie%20review/model/movie_review_model.dart';
import 'package:movieapp/features/movie%20details/trailler/model/trailler_model.dart';
import 'package:movieapp/model/movie_model.dart';

class MovieDetailsRepository {
  Future<Either<String, MovieDetailsModel>> fetchMovieDetails(
      {required int? id}) async {
    try {
      final response = await Dio()
          .get("https://api.themoviedb.org/3/movie/$id?api_key=$apiKey");
      final data = MovieDetailsModel.fromMap(response.data);
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch data");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<MoviesModel>>> fetchMovies(
      {required int? id, required String movieType}) async {
    try {
      final response = await Dio().get(
          "https://api.themoviedb.org/3/movie/$id/$movieType?api_key=$apiKey");
      final data = List.from(response.data["results"])
          .map((e) => MoviesModel.fromMap(e))
          .toList();
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch data");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<TraillerModel>>> fetchMovieTrailler(
      {required int? id}) async {
    try {
      final response = await Dio()
          .get("https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey");
      final data = List.from(response.data["results"])
          .map((e) => TraillerModel.fromMap(e))
          .toList();
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch data");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<MovieReviewModel>>> fetchMovieReview(
      {required int? id}) async {
    try {
      final response = await Dio().get(
          "https://api.themoviedb.org/3/movie/$id/reviews?api_key=$apiKey");
      final data = List.from(response.data["results"])
          .map((e) => MovieReviewModel.fromMap(e))
          .toList();
    return Right(data);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch data");
    } catch (e) {
      return Left(e.toString());
    }
  }


}
