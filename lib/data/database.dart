import 'package:hive_flutter/hive_flutter.dart';

import '../Objects/person_entry.dart';

class CarDatabase {
  List<PersonEntry> people = [];

  final _myBox = Hive.box<PersonEntry>('mybox');
  void createInitialData() {
    print('Creating new sample data');
    people = [];
    updateData();
  }

  void loadData() {
    print('Loading existing data');
    this.people = List<PersonEntry>.from(_myBox.values);
    for (PersonEntry p in this.people) {
      print("person: " + p.name);
    }
  }

  void updateData() {
    print('Updating data');
    for (PersonEntry p in this.people) {
      _myBox.put(p.uid, p);
    }
  }

  void deletePerson(PersonEntry p) {
    _myBox.delete(p.uid);
  }
}

class PersonAdapter extends TypeAdapter<PersonEntry> {
  @override
  PersonEntry read(BinaryReader reader) {
    List<String> readVal = reader.read();
    PersonEntry p = PersonEntry(
      name: readVal[0],
      number: readVal[1],
      budget: readVal[2],
      carModel: readVal[3],
      type: readVal[4],
    );
    p.uid = readVal[5];
    p.created_on = readVal[6];
    return p;
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, PersonEntry obj) {
    List<String> val = [
      obj.name,
      obj.number,
      obj.budget,
      obj.carModel,
      obj.type,
      obj.uid,
      obj.created_on
    ];
    writer.write(val);
  }
}
