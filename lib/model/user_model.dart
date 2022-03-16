class UserModel {
  late String firstName;
  late String lastName;
  late String email;
  late String uId;
  late String? date;
  late String? image;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uId,
    this.date,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    date= json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'uId': uId,
      'image': image,
      'date': date,
    };
  }
}
