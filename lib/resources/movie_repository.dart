import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movieapp/constant/api_key.dart';
import 'package:movieapp/model/movie_model.dart';

class MovieRepository {
  Future<Either<String, List<MoviesModel>>> fetchTrendingMovies(
      {required String trendDay}) async {
    try {
      final response = await Dio().get(
          "https://api.themoviedb.org/3/trending/all/$trendDay?api_key=$apiKey");
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

  Future<Either<String, List<MoviesModel>>> fetchMovies(
      {required String movieType}) async {
    try {
      final response = await Dio()
          .get("https://api.themoviedb.org/3/movie/$movieType?api_key=$apiKey");
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

  Future<Either<String, List<MoviesModel>>> fetchTvSerial(
      {required String serialType}) async {
    try {
      final response = await Dio()
          .get("https://api.themoviedb.org/3/tv/$serialType?api_key=$apiKey");
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

  Future<Either<String, List<MoviesModel>>> searchMovies(
      {required String searchText}) async {
    try {
      final response = await Dio().get(
          "https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$searchText");
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
}
