/// アレルゲンのカテゴリ
enum AllergenCategory {
  /// 義務表示（8品目）
  mandatory,

  /// 推奨表示（20品目）
  recommended,
}

/// アレルゲン一覧（識別子は英語、表示は日本語をマップで管理）
enum Allergen {
  // 義務表示（8品目）
  egg,
  milk,
  wheat,
  soba,
  peanut,
  shrimp,
  crab,
  walnut,

  // 推奨表示（20品目）
  almond,
  abalone,
  squid,
  salmonRoe,
  orange,
  cashewNut,
  kiwi,
  beef,
  sesame,
  salmon,
  mackerel,
  soybean,
  chicken,
  banana,
  pork,
  macadamiaNut,
  peach,
  yam,
  apple,
  gelatin,
}

/// 表示名（日本語）
const Map<Allergen, String> allergenLabel = {
  // 義務表示（8品目）
  Allergen.egg: '卵',
  Allergen.milk: '乳',
  Allergen.wheat: '小麦',
  Allergen.soba: 'そば',
  Allergen.peanut: '落花生',
  Allergen.shrimp: 'えび',
  Allergen.crab: 'かに',
  Allergen.walnut: 'くるみ',

  // 推奨表示（20品目）
  Allergen.almond: 'アーモンド',
  Allergen.abalone: 'あわび',
  Allergen.squid: 'いか',
  Allergen.salmonRoe: 'いくら',
  Allergen.orange: 'オレンジ',
  Allergen.cashewNut: 'カシューナッツ',
  Allergen.kiwi: 'キウイフルーツ',
  Allergen.beef: '牛肉',
  Allergen.sesame: 'ごま',
  Allergen.salmon: 'さけ',
  Allergen.mackerel: 'さば',
  Allergen.soybean: '大豆',
  Allergen.chicken: '鶏肉',
  Allergen.banana: 'バナナ',
  Allergen.pork: '豚肉',
  Allergen.macadamiaNut: 'マカダミアナッツ',
  Allergen.peach: 'もも',
  Allergen.yam: 'やまいも',
  Allergen.apple: 'りんご',
  Allergen.gelatin: 'ゼラチン',
};

/// カテゴリ判定
const Map<Allergen, AllergenCategory> allergenCategory = {
  // 義務表示（8品目）
  Allergen.egg: AllergenCategory.mandatory,
  Allergen.milk: AllergenCategory.mandatory,
  Allergen.wheat: AllergenCategory.mandatory,
  Allergen.soba: AllergenCategory.mandatory,
  Allergen.peanut: AllergenCategory.mandatory,
  Allergen.shrimp: AllergenCategory.mandatory,
  Allergen.crab: AllergenCategory.mandatory,
  Allergen.walnut: AllergenCategory.mandatory,

  // 推奨表示（20品目）
  Allergen.almond: AllergenCategory.recommended,
  Allergen.abalone: AllergenCategory.recommended,
  Allergen.squid: AllergenCategory.recommended,
  Allergen.salmonRoe: AllergenCategory.recommended,
  Allergen.orange: AllergenCategory.recommended,
  Allergen.cashewNut: AllergenCategory.recommended,
  Allergen.kiwi: AllergenCategory.recommended,
  Allergen.beef: AllergenCategory.recommended,
  Allergen.sesame: AllergenCategory.recommended,
  Allergen.salmon: AllergenCategory.recommended,
  Allergen.mackerel: AllergenCategory.recommended,
  Allergen.soybean: AllergenCategory.recommended,
  Allergen.chicken: AllergenCategory.recommended,
  Allergen.banana: AllergenCategory.recommended,
  Allergen.pork: AllergenCategory.recommended,
  Allergen.macadamiaNut: AllergenCategory.recommended,
  Allergen.peach: AllergenCategory.recommended,
  Allergen.yam: AllergenCategory.recommended,
  Allergen.apple: AllergenCategory.recommended,
  Allergen.gelatin: AllergenCategory.recommended,
};

/// カテゴリごとの一覧
final List<Allergen> mandatoryAllergens = Allergen.values
    .where((a) => allergenCategory[a] == AllergenCategory.mandatory)
    .toList(growable: false);

final List<Allergen> recommendedAllergens = Allergen.values
    .where((a) => allergenCategory[a] == AllergenCategory.recommended)
    .toList(growable: false);

/// 並び替え（日本語ラベル昇順）
int compareByLabel(Allergen a, Allergen b) {
  return (allergenLabel[a] ?? a.name).compareTo(allergenLabel[b] ?? b.name);
}
