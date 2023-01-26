import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class SelectContact extends StatefulWidget {
  void Function(String name, String num) setDetails;
  SelectContact({super.key, required this.setDetails});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<Contact>? contacts;

  void getPhoneData() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
    }
    setState(() {});
  }

  @override
  void initState() {
    getPhoneData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Contact'),
        elevation: 0,
      ),
      body: contacts == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts!.length,
              itemBuilder: ((context, index) {
                String number = (contacts![index].phones.isNotEmpty)
                    ? contacts![index].phones.first.number
                    : "-";
                return ListTile(
                  title: Text(contacts![index].displayName),
                  subtitle: Text(number),
                  onTap: () {
                    number = number.replaceAll(' ', '');
                    if (number.startsWith('+')) {
                      number = number.substring(1);
                    }
                    if (number != '-') {
                      widget.setDetails(contacts![index].displayName, number);
                    }
                    Navigator.pop(context);
                  },
                );
              })),
    );
  }
}
