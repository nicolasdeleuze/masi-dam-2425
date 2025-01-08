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
}
