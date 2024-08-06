import 'dart:convert';
import 'dart:developer';

import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/upcoming_model.dart';
import "package:http/http.dart" as http;

var key = "?apikey=$apikey";
late String endpoint;
late String params;

class ApiServices {
  Future<UpcomingMovieModel> getSearchResults(String s) async {
    params = '&s=$s&page=1';
    final url = "$baseURL$key$params";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return upcomingMovieModelFromJson(response.body);
    }
    throw Exception("Failed to load series ");
  }

  Future<UpcomingMovieModel> getSeries() async {
    params = "&s=series&page=1&type=series";
    final url = "$baseURL$key$params";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return upcomingMovieModelFromJson(response.body);
    }
    throw Exception("Failed to load series ");
  }

  Future<UpcomingMovieModel> getUpcomingMovies() async {
    log("url");
    endpoint = "";
    params = "&s=anime&page=3";
    final url = "$baseURL$endpoint$key$params";
    log(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success :${response.body}");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcoming movie ");
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    log("url");
    endpoint = "";
    params = "&s=movie&page=1";
    final url = "$baseURL$endpoint$key$params";
    log(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success :${response.body}");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load now playing movie ");
  }
}
