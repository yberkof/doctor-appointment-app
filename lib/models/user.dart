class User {
  String email;
  String firstName;
  String lastName;
  String schoolName;
  String role;
  String uid;
  String? image = '';

  User(
      {this.image,
      required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.schoolName,
      required this.role});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'schoolName': schoolName,
      'role': role,
      'uid': uid,
      'image': image
    };
  }

  static User fromMap(Map<String, dynamic> data) {
    return User(
        uid: data['uid'],
        role: data['role'],
        schoolName: data['schoolName'],
        lastName: data['lastName'],
        firstName: data['firstName'],
        email: data['email'],
        image: data['image']);
  }
}
