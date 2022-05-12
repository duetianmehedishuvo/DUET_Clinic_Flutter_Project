class MedicineModel {
  String? uId, companyName, name, quantity, price, details;

  MedicineModel({this.uId, this.companyName, this.name, this.quantity, this.price, this.details});

  MedicineModel.fromMap(final map) {
    uId = map['id'];
    companyName = map['companyName'];
    name = map['name'];
    quantity = map['quantity'];
    price = map['price'];
    details = map['details'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = uId;
    map['companyName'] = companyName;
    map['name'] = name;
    map['quantity'] = quantity;
    map['price'] = price;
    map['details'] = details;
    return map;
  }
}
