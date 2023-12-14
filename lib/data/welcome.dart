import 'dart:convert';
import 'package:submission01flutter/data/restaurant.dart';

class Welcome {
  List<Restaurant> restaurants;

  Welcome({
    required this.restaurants,
  });

  Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

  String welcomeToJson(Welcome data) => json.encode(data.toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
      restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
