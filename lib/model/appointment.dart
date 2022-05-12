

class Appointment {
  String name, gender, comment,  clinicName, doctorId, patientId, patientAppointmentId, doctorAppointmentId;
  int age, appointmentNumber;
  bool confirmed;

  Appointment(
      {this.name='',
      this.gender='',
      this.patientAppointmentId='',
      this.doctorAppointmentId='',
      this.comment='',
      this.age=0,
      this.patientId='',
      this.doctorId='',
      this.clinicName='',
      this.confirmed=false,
      this.appointmentNumber=0});
}
