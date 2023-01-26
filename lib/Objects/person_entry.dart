import 'package:uuid/uuid.dart';

var uuid = Uuid();

class PersonEntry {
  String name;
  String number;
  String budget;
  String carModel;
  String type;
  late String uid;
  late String created_on;
  PersonEntry({
    this.name = "",
    this.number = "",
    this.budget = "",
    this.carModel = "",
    this.type = "",
  }) {
    this.name = this.name.trim();
    this.number = this.number.trim();
    this.budget = this.budget.trim();
    this.carModel = this.carModel.trim();
    this.type = this.type.trim();
    this.uid = uuid.v4();
    this.created_on = DateTime.now().toIso8601String();
  }
}
