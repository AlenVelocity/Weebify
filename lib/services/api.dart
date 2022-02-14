import 'package:weebify/models/anime.dart';
import 'package:weebify/models/card.dart';
import 'package:weebify/models/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DataService with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMessage = '';
  List<CardModel> searchList = [];
  List<Recommendation> recommendationList = [];
  late int genreId;
  late Anime animeData = Anime();

  Future<void> getHomeData({String category = 'airing'}) async {
    final String url = 'https://api.jikan.moe/v3/top/anime/1/$category';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List items = response.data['top'];
      searchList = items.map((data) => CardModel.fromJson(data)).toList();
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }

  Future<void> searchData(String query) async {
    final String url =
        'https://api.jikan.moe/v3/search/anime?q=$query&page=1&limit=12';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<CardModel> tempData = [];
      List items = response.data['results'];
      tempData = items.map((data) => CardModel.fromJson(data)).toList();
      searchList = tempData;
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }

  Future<void> getAnimeData(int malId) async {
    final String url = 'https://api.jikan.moe/v3/anime/$malId';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      animeData = Anime.fromJson(response.data);
      await getRecommendationData(animeData.genreId);
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }

  Future<void> getRecommendationData(int genreId) async {
    final String url = 'https://api.jikan.moe/v3/genre/anime/$genreId/1';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<Recommendation> tempRecommendation = [];
      List items = response.data['anime'];
      tempRecommendation =
          items.map((data) => Recommendation.fromJson(data)).take(5).toList();
      recommendationList = tempRecommendation;
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }
}
