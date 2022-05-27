import 'package:medicare/services/vaccines_service.dart';

class VaccineMigration {
  void migrateVaccineSecondDose() {
    VaccinesService.shared.vaccines
        .where('hasSecondDose', isEqualTo: null)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        VaccinesService.shared.vaccines
            .doc(element.id)
            .update({'hasSecondDose': false});
      });
    });
  }
}
