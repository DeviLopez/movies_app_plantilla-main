// To parse this JSON data, do
//
//     final populars = popularsFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class Populars {
  Populars({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory Populars.fromJson(String str) => Populars.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory Populars.fromMap(Map<String, dynamic> json) => Populars(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  // Map<String, dynamic> toMap() => {
  //       "page": page,
  //       "results": List<dynamic>.from(results.map((x) => x.toMap())),
  //       "total_pages": totalPages,
  //       "total_results": totalResults,
  //     };
}
