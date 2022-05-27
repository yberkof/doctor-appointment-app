import 'package:firebase_core/firebase_core.dart';
import 'package:medicare/services/users_service.dart';

class UserMigration {
  void migrateUserCity() {
    UsersService.shared.users
        .where('city', isEqualTo: null)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        UsersService.shared.users.doc(element.id).update({'city': 'Amman'});
      });
    });
  }
}

void main() async {
  await Firebase.initializeApp();
  UserMigration().migrateUserCity();
}
