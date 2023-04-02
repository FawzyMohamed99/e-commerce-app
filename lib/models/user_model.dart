class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  //constructor
  UserModel(this.name, this.email, this.phone, this.image, this.token);

  //named constructor
  UserModel.fromJson({required Map<String, dynamic> data}) {
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    token = data['token'];
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
      'image': image,
    };
  }
}
