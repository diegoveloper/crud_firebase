import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:flutter/material.dart';

class ListNoRealtimeProvider extends ChangeNotifier {
  ListNoRealtimeProvider({required this.personRepository});

  final PersonRepository personRepository;

  List<Person>? persons;

  Future<void> load() async {
    persons = await personRepository.getPersons();
    notifyListeners();
  }

  Future<void> delete(String docId) async {
    await personRepository.deletePerson(docId);
    load();
  }
}
