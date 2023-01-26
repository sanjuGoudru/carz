import 'package:flutter/material.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carz'),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 166, 218, 242),
      // body:
    );
  }
}
