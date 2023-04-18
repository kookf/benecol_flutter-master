import 'package:benecol_flutter/models/food.dart';

List<Map<String, String>> getFoodTypes(String langCode){
  final Map<String, dynamic> foodTypes = {
    "en": [
      {
        "value": "1",
        "text": "Grains"
      },
      {
        "value": "2",
        "text": "Egg"
      },
      {
        "value": "3",
        "text": "Meat"
      },
      {
        "value": "4",
        "text": "Seafood"
      },
      {
        "value": "5",
        "text": "Organs"
      },
      {
        "value": "6",
        "text": "Fruit and Vegetable"
      },
      {
        "value": "7",
        "text": "Oil"
      },
      {
        "value": "8",
        "text": "Chinese Dim Sum"
      },
      {
        "value": "9",
        "text": "Drink"
      },
      {
        "value": "10",
        "text": "Fast Food and Snack"
      }
    ],
    "zh_Hant": [
      {
        "value": "1",
        "text": "五穀類"
      },
      {
        "value": "2",
        "text": "蛋類"
      },
      {
        "value": "3",
        "text": "肉類"
      },
      {
        "value": "4",
        "text": "海產類"
      },
      {
        "value": "5",
        "text": "內臟類"
      },
      {
        "value": "6",
        "text": "蔬果類"
      },
      {
        "value": "7",
        "text": "油類"
      },
      {
        "value": "8",
        "text": "中式點心類"
      },
      {
        "value": "9",
        "text": "飲品"
      },
      {
        "value": "10",
        "text": "快餐及零食類"
      }
    ]
  };
  return foodTypes[langCode];
}

List<Food> getFoods(String langCode){
  final Map<String, List<Food>> foods = {
    "en": [
      Food(
        id: 1,
        typeId: 1,
        food: "Rice",
        qty: 1,
        accQty: 1,
        unit: "Bowl",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "Fried Rice",
        qty: 1,
        accQty: 1,
        unit: "Bowl",
        unitExtra: "",
        chol: 61,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "Steamed Rice with Barbecued Pork",
        qty: 1,
        accQty: 1,
        unit: "Bowl",
        unitExtra: "",
        chol: 44,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "Steamed Spare Ribs with Rice",
        qty: 1,
        accQty: 1,
        unit: "Bowl",
        unitExtra: "",
        chol: 64,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "Macaroni",
        qty: 1,
        accQty: 1,
        unit: "Bowl",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "Dry Fried Flat Rice Noodle with Beef",
        qty: 1,
        accQty: 1,
        unit: "Dish",
        unitExtra: "",
        chol: 50,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "White Bread",
        qty: 2,
        accQty: 2,
        unit: "Slides",
        unitExtra: "",
        chol: 1,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "Whole Wheat Bread",
        qty: 2,
        accQty: 2,
        unit: "Slides",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "Chiffon Cake",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 114,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "Duck Egg",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 619,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "Egg",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 213,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "Egg yolk",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 213,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "Egg white",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "Quail Egg",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 74,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Pork (fat)",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 109,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Pork (lean)",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 81,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Lamb (half fat)",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 92,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Lamb (lean)",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 60,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Roast Duck ",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Chicken Sausage",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 46,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Ham",
        qty: 1,
        accQty: 1,
        unit: "Slide",
        unitExtra: "",
        chol: 18,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Luncheon Meat",
        qty: 1,
        accQty: 1,
        unit: "Slide",
        unitExtra: "",
        chol: 20,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Chinese Sausage",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 150,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Spare Ribs",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 121,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Chicken Leg (with skin)",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 93,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Chicken Breast (with skin)",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Chicken Paw",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Beef (semi fat)",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "Beef (lean)",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 58,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Sea Cucumber",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Jellyfish",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 16,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "General Fish",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 80,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Codfish",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 68,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Grouper",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 47,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Cuttlefish",
        qty: 1.5,
        accQty: 1.5,
        unit: "Bowl",
        unitExtra: "",
        chol: 248,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Squid",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 233,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Abalone",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 85,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Shrimp",
        qty: 1,
        accQty: 1,
        unit: "Bowl",
        unitExtra: "",
        chol: 152,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Lobster",
        qty: 1,
        accQty: 1,
        unit: "Bowl",
        unitExtra: "",
        chol: 95,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Crab",
        qty: 0.5,
        accQty: 0.5,
        unit: "Bowl",
        unitExtra: "",
        chol: 78,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Tape",
        qty: 0.33,
        accQty: 0.33,
        unit: "Bowl",
        unitExtra: "",
        chol: 33,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Clam",
        qty: 1.5,
        accQty: 1.5,
        unit: "Bowl",
        unitExtra: "",
        chol: 34,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Oyster",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 2.5,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "Sear Urchin",
        qty: 100,
        accQty: 100,
        unit: "g",
        unitExtra: "",
        chol: 55,
        isChecked: false
      ),
      Food(
        id: 5,
        typeId: 5,
        food: "Pig Brain",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 2571,
        isChecked: false
      ),
      Food(
        id: 5,
        typeId: 5,
        food: "Pig Kidney",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 3154,
        isChecked: false
      ),
      Food(
        id: 5,
        typeId: 5,
        food: "Pig Liver",
        qty: 94,
        accQty: 94,
        unit: "g",
        unitExtra: "",
        chol: 355,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "Boiled Vegetable",
        qty: 113,
        accQty: 113,
        unit: "g",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "Stir-fry Vegetable",
        qty: 113,
        accQty: 113,
        unit: "g",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "Orange",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "(med.)",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "Apple",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "(med.)",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "Butter",
        qty: 1,
        accQty: 1,
        unit: "Tablespoon",
        unitExtra: "",
        chol: 11,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "Lard",
        qty: 100,
        accQty: 100,
        unit: "g",
        unitExtra: "",
        chol: 95,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "Chicken Grease",
        qty: 100,
        accQty: 100,
        unit: "g",
        unitExtra: "",
        chol: 85,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "Vegetable Oil",
        qty: 1,
        accQty: 1,
        unit: "Tablespoon",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "Salad Dressing",
        qty: 1,
        accQty: 1,
        unit: "Teaspoon",
        unitExtra: "",
        chol: 2,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "Shrimp Dumpling",
        qty: 1,
        accQty: 1,
        unit: "Bamboo Basket",
        unitExtra: "(4pcs.)",
        chol: 24,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "Dumpling",
        qty: 1,
        accQty: 1,
        unit: "Bamboo Basket",
        unitExtra: "(4pcs.)",
        chol: 24,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "Beef Rice Roil",
        qty: 1,
        accQty: 1,
        unit: "Dish",
        unitExtra: "(3pcs.)",
        chol: 24,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "Taro Turnover",
        qty: 1,
        accQty: 1,
        unit: "Dish",
        unitExtra: "(3pcs.)",
        chol: 9,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "Glutinous Rice in Lotus Leaf",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 16,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "Pan-Fried Mooli Cake",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 9,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "Whole Milk",
        qty: 1,
        accQty: 1,
        unit: "Cup",
        unitExtra: "",
        chol: 26,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "Skim Milk",
        qty: 1,
        accQty: 1,
        unit: "Cup",
        unitExtra: "",
        chol: 5,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "Plain Milkshake",
        qty: 1,
        accQty: 1,
        unit: "Cup",
        unitExtra: "",
        chol: 30,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "Coffee/ Milk Tea",
        qty: 1,
        accQty: 1,
        unit: "Cup",
        unitExtra: "",
        chol: 5,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "Soy Milk",
        qty: 250,
        accQty: 250,
        unit: "ml",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "Soft Drink",
        qty: 355,
        accQty: 355,
        unit: "ml",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "Beer",
        qty: 355,
        accQty: 355,
        unit: "ml",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Pineapple Bun",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 17,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Sausage Muffin with Egg",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 270,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Big Mac",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 100,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Filet-O-Fish",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 50,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Hamburger",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 30,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Pizza",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 30,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "French Fries",
        qty: 1,
        accQty: 1,
        unit: "Packet",
        unitExtra: "(small)",
        chol: 9,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "French Toast",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 119,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Egg Tart",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 67,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Cake ",
        qty: 1,
        accQty: 1,
        unit: "Pc",
        unitExtra: "",
        chol: 66,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Beef Jerky",
        qty: 100,
        accQty: 100,
        unit: "g",
        unitExtra: "",
        chol: 48,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Potato Chips",
        qty: 100,
        accQty: 100,
        unit: "g",
        unitExtra: "",
        chol: 4,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Ice Cream",
        qty: 100,
        accQty: 100,
        unit: "g",
        unitExtra: "",
        chol: 44,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Crispy Rice Cake",
        qty: 100,
        accQty: 100,
        unit: "g",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "Soda Cracker",
        qty: 1,
        accQty: 1,
        unit: "Slide",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
    ],
    "zh_Hant": [
      Food(
        id: 1,
        typeId: 1,
        food: "白飯",
        qty: 1,
        accQty: 1,
        unit: "碗",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "炒飯",
        qty: 1,
        accQty: 1,
        unit: "碗",
        unitExtra: "",
        chol: 61,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "叉燒飯",
        qty: 1,
        accQty: 1,
        unit: "碗",
        unitExtra: "",
        chol: 44,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "排骨飯",
        qty: 1,
        accQty: 1,
        unit: "盅",
        unitExtra: "",
        chol: 64,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "通心粉",
        qty: 1,
        accQty: 1,
        unit: "碗",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "乾炒牛河",
        qty: 1,
        accQty: 1,
        unit: "碟",
        unitExtra: "",
        chol: 50,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "白麵包",
        qty: 2,
        accQty: 2,
        unit: "片",
        unitExtra: "",
        chol: 1,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "全麥麵包",
        qty: 2,
        accQty: 2,
        unit: "片",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 1,
        typeId: 1,
        food: "雪芳蛋糕",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "",
        chol: 114,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "鴨蛋",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 619,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "雞蛋",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 213,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "蛋黃",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 213,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "蛋白",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 2,
        typeId: 2,
        food: "鵪鶉蛋",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 74,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "豬肉(肥)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 109,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "豬肉(瘦)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 81,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "羊肉(半肥)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 92,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "羊肉(瘦)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 60,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "燒鴨(連皮)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "雞肉腸",
        qty: 1,
        accQty: 1,
        unit: "條",
        unitExtra: "",
        chol: 46,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "火腿",
        qty: 1,
        accQty: 1,
        unit: "片",
        unitExtra: "",
        chol: 18,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "午餐肉",
        qty: 1,
        accQty: 1,
        unit: "片",
        unitExtra: "",
        chol: 20,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "臘腸",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 150,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "排骨",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 121,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "雞腿(連皮)",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 93,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "雞胸(連皮)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "雞腳",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "牛肉(半肥)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 84,
        isChecked: false
      ),
      Food(
        id: 3,
        typeId: 3,
        food: "牛肉(瘦)",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 58,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "海參",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "海蜇",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 16,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "一般魚類",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 80,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "銀鱈魚",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 68,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "石斑魚",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 47,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "墨魚",
        qty: 1.5,
        accQty: 1.5,
        unit: "碗",
        unitExtra: "",
        chol: 248,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "魷魚",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 233,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "鮑魚",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 85,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "蝦",
        qty: 1,
        accQty: 1,
        unit: "碗",
        unitExtra: "",
        chol: 152,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "龍蝦",
        qty: 1,
        accQty: 1,
        unit: "碗",
        unitExtra: "",
        chol: 95,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "蟹",
        qty: 0.5,
        accQty: 0.5,
        unit: "碗",
        unitExtra: "",
        chol: 78,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "帶子",
        qty: 0.33,
        accQty: 0.33,
        unit: "碗",
        unitExtra: "",
        chol: 33,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "蜆",
        qty: 1.5,
        accQty: 1.5,
        unit: "碗",
        unitExtra: "",
        chol: 34,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "生蠔",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 2.5,
        isChecked: false
      ),
      Food(
        id: 4,
        typeId: 4,
        food: "海膽",
        qty: 100,
        accQty: 100,
        unit: "克",
        unitExtra: "",
        chol: 55,
        isChecked: false
      ),
      Food(
        id: 5,
        typeId: 5,
        food: "豬腦",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 2571,
        isChecked: false
      ),
      Food(
        id: 5,
        typeId: 5,
        food: "豬腰",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 3154,
        isChecked: false
      ),
      Food(
        id: 5,
        typeId: 5,
        food: "豬肝",
        qty: 94,
        accQty: 94,
        unit: "克",
        unitExtra: "",
        chol: 355,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "烚菜",
        qty: 113,
        accQty: 113,
        unit: "克",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "炒菜",
        qty: 113,
        accQty: 113,
        unit: "克",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "橙",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "(中)",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 6,
        typeId: 6,
        food: "蘋果",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "(中)",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "牛油",
        qty: 1,
        accQty: 1,
        unit: "湯匙",
        unitExtra: "",
        chol: 11,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "豬油",
        qty: 100,
        accQty: 100,
        unit: "克",
        unitExtra: "",
        chol: 95,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "雞油",
        qty: 100,
        accQty: 100,
        unit: "克",
        unitExtra: "",
        chol: 85,
        isChecked: false
      ),
      Food(
        id: 7,
        typeId: 7,
        food: "植物油",
        qty: 1,
        accQty: 1,
        unit: "湯匙",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "沙律醬",
        qty: 1,
        accQty: 1,
        unit: "茶匙",
        unitExtra: "",
        chol: 2,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "蝦餃",
        qty: 1,
        accQty: 1,
        unit: "籠",
        unitExtra: "(4粒)",
        chol: 24,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "燒賣",
        qty: 1,
        accQty: 1,
        unit: "籠",
        unitExtra: "(4粒)",
        chol: 24,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "牛肉腸粉",
        qty: 1,
        accQty: 1,
        unit: "碟",
        unitExtra: "(3條)",
        chol: 24,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "芋角",
        qty: 1,
        accQty: 1,
        unit: "碟",
        unitExtra: "(3隻)",
        chol: 9,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "珍珠雞",
        qty: 1,
        accQty: 1,
        unit: "隻",
        unitExtra: "",
        chol: 16,
        isChecked: false
      ),
      Food(
        id: 8,
        typeId: 8,
        food: "蘿蔔糕(煎)",
        qty: 1,
        accQty: 1,
        unit: "件",
        unitExtra: "",
        chol: 9,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "全脂奶",
        qty: 1,
        accQty: 1,
        unit: "杯",
        unitExtra: "",
        chol: 26,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "脫脂奶",
        qty: 1,
        accQty: 1,
        unit: "杯",
        unitExtra: "",
        chol: 5,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "原味奶昔",
        qty: 1,
        accQty: 1,
        unit: "杯",
        unitExtra: "",
        chol: 30,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "咖啡/奶茶",
        qty: 1,
        accQty: 1,
        unit: "杯",
        unitExtra: "",
        chol: 5,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "豆奶",
        qty: 250,
        accQty: 250,
        unit: "毫升",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "汽水",
        qty: 355,
        accQty: 355,
        unit: "毫升",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 9,
        typeId: 9,
        food: "啤酒",
        qty: 355,
        accQty: 355,
        unit: "毫升",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "菠蘿包",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "",
        chol: 17,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "豬柳蛋漢堡",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "",
        chol: 270,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "巨無霸",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "",
        chol: 100,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "魚柳包",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "",
        chol: 50,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "漢堡包",
        qty: 1,
        accQty: 1,
        unit: "個",
        unitExtra: "",
        chol: 30,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "意大利薄餅",
        qty: 1,
        accQty: 1,
        unit: "件",
        unitExtra: "",
        chol: 30,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "薯條",
        qty: 1,
        accQty: 1,
        unit: "包",
        unitExtra: "(細)",
        chol: 9,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "西多士",
        qty: 1,
        accQty: 1,
        unit: "客",
        unitExtra: "",
        chol: 119,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "蛋撻",
        qty: 1,
        accQty: 1,
        unit: "件",
        unitExtra: "",
        chol: 67,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "西餅",
        qty: 1,
        accQty: 1,
        unit: "件",
        unitExtra: "",
        chol: 66,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "牛肉乾",
        qty: 100,
        accQty: 100,
        unit: "克",
        unitExtra: "",
        chol: 48,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "薯片",
        qty: 100,
        accQty: 100,
        unit: "克",
        unitExtra: "",
        chol: 4,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "雪糕",
        qty: 100,
        accQty: 100,
        unit: "克",
        unitExtra: "",
        chol: 44,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "米通",
        qty: 100,
        accQty: 100,
        unit: "克",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
      Food(
        id: 10,
        typeId: 10,
        food: "梳打餅",
        qty: 1,
        accQty: 1,
        unit: "片",
        unitExtra: "",
        chol: 0,
        isChecked: false
      ),
    ]
  };
  return foods[langCode] ?? [];
}