import 'package:flutter/material.dart';

import 'allergen.dart';

/// アレルゲンに対応するアイコン（適当な近似アイコン）
IconData iconForAllergen(Allergen allergen) {
  switch (allergen) {
    // 義務表示（8品目）
    case Allergen.egg:
      return Icons.egg;
    case Allergen.milk:
      return Icons.local_drink;
    case Allergen.wheat:
      return Icons.grain;
    case Allergen.soba:
      return Icons.ramen_dining;
    case Allergen.peanut:
      return Icons.spa; // ナッツ系の葉っぱで代替
    case Allergen.shrimp:
      return Icons.set_meal;
    case Allergen.crab:
      return Icons.set_meal;
    case Allergen.walnut:
      return Icons.spa;

    // 推奨表示（20品目）
    case Allergen.almond:
      return Icons.spa;
    case Allergen.abalone:
      return Icons.set_meal;
    case Allergen.squid:
      return Icons.set_meal;
    case Allergen.salmonRoe:
      return Icons.set_meal;
    case Allergen.orange:
      return Icons.local_florist;
    case Allergen.cashewNut:
      return Icons.spa;
    case Allergen.kiwi:
      return Icons.local_florist;
    case Allergen.beef:
      return Icons.lunch_dining;
    case Allergen.sesame:
      return Icons.grain;
    case Allergen.salmon:
      return Icons.set_meal;
    case Allergen.mackerel:
      return Icons.set_meal;
    case Allergen.soybean:
      return Icons.grass; // 植物系で代替
    case Allergen.chicken:
      return Icons.lunch_dining;
    case Allergen.banana:
      return Icons.local_florist; // フルーツの代替
    case Allergen.pork:
      return Icons.lunch_dining;
    case Allergen.macadamiaNut:
      return Icons.spa;
    case Allergen.peach:
      return Icons.local_florist;
    case Allergen.yam:
      return Icons.spa;
    case Allergen.apple:
      return Icons.local_florist;
    case Allergen.gelatin:
      return Icons.restaurant;
  }
}

/// カテゴリごとの色（必須:赤系 / 推奨:青系）
Color colorForAllergen(Allergen allergen, ThemeData theme) {
  final category = allergenCategory[allergen];
  if (category == AllergenCategory.mandatory) {
    return theme.colorScheme.errorContainer;
  }
  return theme.colorScheme.primaryContainer;
}
