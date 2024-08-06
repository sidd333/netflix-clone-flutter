// To parse this JSON data, do
//
//     final upcomingMovieModel = upcomingMovieModelFromJson(jsonString);

import 'dart:convert';

UpcomingMovieModel upcomingMovieModelFromJson(String str) =>
    UpcomingMovieModel.fromJson(json.decode(str));

String upcomingMovieModelToJson(UpcomingMovieModel data) =>
    json.encode(data.toJson());

class UpcomingMovieModel {
  List<Search> search;
  String totalResults;
  String response;

  UpcomingMovieModel({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  factory UpcomingMovieModel.fromJson(Map<String, dynamic> json) =>
      UpcomingMovieModel(
        search:
            List<Search>.from(json["Search"].map((x) => Search.fromJson(x))),
        totalResults: json["totalResults"],
        response: json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Search": List<dynamic>.from(search.map((x) => x.toJson())),
        "totalResults": totalResults,
        "Response": response,
      };
}

class Search {
  String title;
  String year;
  String imdbId;
  Type type;
  String poster;

  Search({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        type: typeValues.map[json["Type"]]!,
        poster: json["Poster"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "imdbID": imdbId,
        "Type": typeValues.reverse[type],
        "Poster": poster,
      };
}

enum Type { MOVIE, SERIES }

final typeValues = EnumValues({"movie": Type.MOVIE, "series": Type.SERIES});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
