class User {
  String email;
  String firstName;
  String lastName;
  String role;
  String uid;
  String? image = '';
  String city = '';

  User(
      {this.image,
      required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.city});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'uid': uid,
      'city': city,
      'image': image
    };
  }

  static User fromMap(Map<String, dynamic> data) {
    return User(
        uid: data['uid'],
        role: data['role'],
        lastName: data['lastName'],
        firstName: data['firstName'],
        email: data['email'],
        city: data['city'],
        image: data['image']);
  }
}
