import '../services/child_service.dart';

class ChildMigration {
  void migrateChildrenTakenVaccines() async {
    var children = await ChildService.shared.children;
    children.get().then((value) {
      value.docs.forEach((element) {
        var data = (element.data() as Map<String, dynamic>)['takenVaccines']
            as List<dynamic>;
        for (var value in data) {
          if (!value.containsKey('isSecondDose')) {
            value['isSecondDose'] = false;
          }

          ChildService.shared.children
              .doc(element.id)
              .update({'takenVaccines': data});
        }
      });
    });
  }
}
