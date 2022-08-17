import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:flutter/material.dart';

class ListNoRealtimeProvider extends ChangeNotifier {
  ListNoRealtimeProvider({required this.personRepository});

  final PersonRepository personRepository;

  List<Person>? persons;

  void update(Person person) {
    final index = persons?.indexWhere((e) => e.id == person.id);
    if (index != null && index >= 0) {
      persons?[index] = person;
      notifyListeners();
    }
  }

  void add(Person person) {
    persons?.add(person);
    notifyListeners();
  }

  Future<void> load() async {
    persons = await personRepository.getPersons();
    notifyListeners();
  }

  Future<void> delete(String docId) async {
    await personRepository.deletePerson(docId);
    //load();
    persons?.removeWhere((element) => element.id == docId);
    notifyListeners();
  }
}
