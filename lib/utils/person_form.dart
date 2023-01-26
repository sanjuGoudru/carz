import 'package:flutter/material.dart';
import 'package:carz/Objects/person_entry.dart';
import 'package:carz/pages/select_contact.dart';

class PersonForm extends StatefulWidget {
  void Function(PersonEntry p) onSubmit;
  PersonForm({super.key, required this.onSubmit});

  @override
  State<PersonForm> createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _formKey = GlobalKey<FormState>();
  late PersonEntry person = new PersonEntry(type: 'Buyer');
  void setPhoneNumberFromContacts(String name, String num) {
    setState(() {
      _Numbercontroller.text = num;
      _Namecontroller.text = name.trim();
    });
  }

  final TextEditingController _Numbercontroller = TextEditingController();
  final TextEditingController _Namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => SelectContact(
                            setDetails: setPhoneNumberFromContacts)),
                      ),
                    );
                  },
                  child: Text('Select from contact'),
                ),
                TextFormField(
                  controller: _Namecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (newValue) {
                    print('saved person name: ' + newValue);
                    this.person.name = newValue.trim();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter correct name";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _Numbercontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter correct number";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (newValue) {
                    print('saved person number: ' + newValue);
                    this.person.number = newValue.trim();
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Budget',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter correct budget";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (newValue) {
                    this.person.budget = newValue.trim();
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Car Model',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter correct model";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (newValue) {
                    this.person.carModel = newValue.trim();
                  },
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Type',
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text('Buyer'),
                      value: 'Buyer',
                    ),
                    DropdownMenuItem(
                      child: Text('Seller'),
                      value: 'Seller',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      this.person.type = value!;
                    });
                  },
                  value: this.person.type,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('Save', style: TextStyle(fontSize: 19)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              person.name = _Namecontroller.text.trim();
                              person.number = _Numbercontroller.text.trim();

                              widget.onSubmit(person);
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_forward,
                            )),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
