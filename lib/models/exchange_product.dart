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