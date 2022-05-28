import '../services/appointments_service.dart';

class AppointmentMigration {
  void migrateAppointmentSecondDose() {
    AppointmentsService.shared.appointments
        .where('isSecondDose', isEqualTo: null)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        AppointmentsService.shared.appointments
            .doc(element.id)
            .update({'isSecondDose': false});
      });
    });
  }

  void migrateAppointmentRegions() {
    AppointmentsService.shared.appointments
        .where('region', isEqualTo: null)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        AppointmentsService.shared.appointments
            .doc(element.id)
            .update({'region': 'Amman'});
      });
    });
  }
}
