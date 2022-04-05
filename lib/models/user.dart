class User {
  String email;
  String firstName;
  String lastName;
  String role;
  String uid;
  String? image = '';

  User(
      {this.image,
      required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.role});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'uid': uid,
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
        image: data['image']);
  }
}
