class Food {
  late int id;
  late int typeId;
  late String food;
  late double qty;
  late double accQty;
  late String unit;
  late String unitExtra;
  late double chol;
  late bool isChecked;

  Food({
    required this.id,
      required this.typeId,
      required this.food,
      required this.qty,
      required this.accQty,
      required this.unit,
      required this.unitExtra,
      required this.chol,
      required this.isChecked
  });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    food = json['food'];
    qty = json['qty'];
    accQty = json['acc_qty'];
    unit = json['unit'];
    unitExtra = json['unit_extra'];
    chol = json['chol'];
    isChecked = json['is_checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['food'] = this.food;
    data['qty'] = this.qty;
    data['acc_qty'] = this.accQty;
    data['unit'] = this.unit;
    data['unit_extra'] = this.unitExtra;
    data['chol'] = this.chol;
    data['is_checked'] = this.isChecked;
    return data;
  }
}

class ExchangeProduct {
  late int id;
  late String title;
  late String requiredPoints;
  late String price;
  late String image;
  late String description;
  late String subTitle;
  late String quanity;
  late int shipmentType;

  ExchangeProduct({
    required this.id,
    required this.title,
    required this.requiredPoints,
    required this.price,
    required this.image,
    required this.description,
    required this.subTitle,
    required this.quanity,
    required this.shipmentType
  });

  ExchangeProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    requiredPoints = json['requiredPoints'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    subTitle = json['subTitle'];
    quanity = json['quanity'];
    shipmentType = json['shipmentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['requiredPoints'] = this.requiredPoints;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    data['subTitle'] = this.subTitle;
    data['quanity'] = this.quanity;
    data['shipmentType'] = this.shipmentType;
    return data;
  }
}