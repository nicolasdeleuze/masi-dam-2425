import 'package:masi_dam_2425/model/menu.dart';

enum MenuCategory {
  // Beverage
  soft,
  beer,
  wine,
  cocktail,
  hotDrink,
  spirits,
  juice,
  smoothie,
  water,
  // Food
  fastFood,
  pizza,
  pasta,
  sandwich,
  vegetable,
  barbecue,
  dessert,
  snacks,
  exotic
}

extension MenuCategoryExtension on MenuCategory {

  static int get nbCategory => MenuCategory.values.length;

  String get displayName {
    switch (this) {
      case MenuCategory.soft:
        return "Soft Drink";
      case MenuCategory.beer:
        return "Beer";
      case MenuCategory.wine:
        return "Wine";
      case MenuCategory.cocktail:
        return "Cocktail";
      case MenuCategory.hotDrink:
        return "Hot Drink";
      case MenuCategory.spirits:
        return "Spirits";
      case MenuCategory.juice:
        return "Juice";
      case MenuCategory.smoothie:
        return "Smoothie";
      case MenuCategory.water:
        return "Water";
      case MenuCategory.fastFood:
        return "Fast Food";
      case MenuCategory.pizza:
        return "Pizza";
      case MenuCategory.pasta:
        return "Pasta";
      case MenuCategory.sandwich:
        return "Sandwich";
      case MenuCategory.vegetable:
        return "Vegetable";
      case MenuCategory.barbecue:
        return "Barbecue";
      case MenuCategory.dessert:
        return "Dessert";
      case MenuCategory.snacks:
        return "Snacks";
      case MenuCategory.exotic:
        return "Exotic";
    }
  }

  String get iconName {
    switch (this) {
      case MenuCategory.soft:
        return "soft.png";
      case MenuCategory.beer:
        return "beer.png";
      case MenuCategory.wine:
        return "wine.png";
      case MenuCategory.cocktail:
        return "cocktail.png";
      case MenuCategory.hotDrink:
        return "hotDrink.png";
      case MenuCategory.spirits:
        return "spirits.png";
      case MenuCategory.juice:
        return "juice.png";
      case MenuCategory.smoothie:
        return "smoothie.png";
      case MenuCategory.water:
        return "water.png";
      case MenuCategory.fastFood:
        return "fastFood.png";
      case MenuCategory.pizza:
        return "pizza.png";
      case MenuCategory.pasta:
        return "pasta.png";
      case MenuCategory.sandwich:
        return "sandwich.png";
      case MenuCategory.vegetable:
        return "vegetable.png";
      case MenuCategory.barbecue:
        return "barbecue.png";
      case MenuCategory.dessert:
        return "dessert.png";
      case MenuCategory.snacks:
        return "snacks.png";
      case MenuCategory.exotic:
        return "exotic.png";
    }
  }
}
