import 'package:flutter/material.dart';
import 'package:carz/Objects/person_entry.dart';
import 'package:carz/data/database.dart';
import 'package:carz/pages/person_tile.dart';
import 'package:carz/utils/person_form.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box<PersonEntry>('mybox');
  int bottomNavIndex = 0;
  CarDatabase db = CarDatabase();
  void savePerson(PersonEntry p) {
    setState(() {
      db.people.add(p);
    });
    db.updateData();
  }

  void deletePerson(int index) {
    setState(() {
      PersonEntry p = db.people[index];
      db.people.removeAt(index);
      db.deletePerson(p);
    });
    db.updateData();
  }

  callPerson(int index) async {
    print('callPerson started');
    String number = db.people[index].number;
    if (number.isNotEmpty) {
      final Uri phoneNumUri = Uri.parse('tel:' + number);
      if (await canLaunchUrl(phoneNumUri)) {
        await launchUrl(phoneNumUri);
      }
    }
  }

  void whatsappPerson(int index) async {
    print('whatsappPerson started');
    String number = db.people[index].number;
    if (number.isNotEmpty) {
      var whatsappURl_android = "whatsapp://send?phone=" + number + "&text=";
      // String url = "https://api.whatsapp.com/send?phone=91" + number;
      print('whatsappPerson url:' + whatsappURl_android);

      final Uri whatsappUri = Uri.parse(whatsappURl_android);
      // await launchUrl(whatsappUri);
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      }
      // await FlutterLaunch.launchWhatsapp(
      //   phone: "91" + number,
      //   message: "hello",
      // );
    }
  }

  @override
  void initState() {
    if (_myBox.values.length == 0) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carz'),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 166, 218, 242),
      body: ListView.builder(
        itemCount: db.people.length,
        itemBuilder: (context, index) {
          return PersonTile(
            person: db.people[index],
            deletePersonFunction: (context) => deletePerson(index),
            callPersonFunction: (context) => callPerson(index),
            whatsappPersonFunction: (context) => whatsappPerson(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => PersonForm(onSubmit: savePerson))));
        },
      ),
    );
  }
}
