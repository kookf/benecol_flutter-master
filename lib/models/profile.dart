class Profile {
  late String firstName;
  late String lastName;
  late String phone;
  late String birthday;
  late String gender;
  late String areaId;
  late String income;
  late String email;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.areaId,
    required this.income,
    required this.email
  });

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    birthday = json['birthday'];
    gender = json['gender'];
    areaId = json['area_id'];
    income = json['income'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['area_id'] = this.areaId;
    data['income'] = this.income;
    data['email'] = this.email;
    return data;
  }
}