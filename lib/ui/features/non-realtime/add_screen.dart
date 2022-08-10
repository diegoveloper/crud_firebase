import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:crud_firebase/ui/features/non-realtime/add_provider.dart';
import 'package:crud_firebase/ui/features/non-realtime/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen._();

  static Widget init({Person? person}) => ChangeNotifierProvider(
        lazy: false,
        create: (context) => AddProvider(
          personRepository: context.read<PersonRepository>(),
          person: person,
        ),
        child: const AddScreen._(),
      );

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _controllerName = TextEditingController();
  final _controllerLastname = TextEditingController();
  final _controllerGender = TextEditingController();

  Future<void> _loadInit() async {
    final person = context.read<AddProvider>().person;
    if (person != null) {
      _controllerName.text = person.name;
      _controllerLastname.text = person.lastname;
      _controllerGender.text = person.gender;
    }
  }

  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
            ),
            TextField(
              controller: _controllerLastname,
              decoration: const InputDecoration(
                label: Text('Last Name'),
              ),
            ),
            TextField(
              controller: _controllerGender,
              decoration: const InputDecoration(
                label: Text('Gender'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          final newPerson = Person(
            name: _controllerName.text,
            lastname: _controllerLastname.text,
            gender: _controllerGender.text,
          );
          await context.read<AddProvider>().add(newPerson);
          if (mounted) Navigator.of(context).pop();
        },
      ),
    );
  }
}
