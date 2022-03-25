class MyUser {
  final String uid;
  final String displayName;
  final String email;
  final String photoURL;
  bool isDoctor = false;

  MyUser({this.uid = '', this.displayName = '', this.email = '', this.photoURL = ''});
}

class Doctor {
  String? clinicName, educationalQualification, timing, address, fee, paymentMethod, bio, uid, displayName, email, photoURL;
  int? counter;

  Doctor(
      {this.uid,
      this.displayName,
      this.email,
      this.photoURL,
      this.clinicName,
      this.educationalQualification,
      this.timing,
      this.address,
      this.fee,
      this.paymentMethod,
      this.bio,
      this.counter});
}

class ShortDoctor{
  String? uId,categoryName,name,clinicName,image;

  ShortDoctor({this.uId, this.categoryName, this.name, this.clinicName,image});

  ShortDoctor.fromMap(final map){
    uId=map['id'];
    categoryName=map['category'];
    name=map['displayName'];
    clinicName=map['clinicName'];
    image=map['image'];
  }
}
