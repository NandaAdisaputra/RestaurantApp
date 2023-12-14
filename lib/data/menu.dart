import 'menu/drink.dart';
import 'menu/foods.dart';

class Menu {
  List<Food> foods;
  List<Drink> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
      foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
