import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:flutter/material.dart';

class AddProvider extends ChangeNotifier {
  AddProvider({
    required this.personRepository,
    this.person,
  });

  final PersonRepository personRepository;
  final Person? person;

  Future<bool> add(Person newPerson) async {
    if (person != null) {
      await personRepository.updatePerson(newPerson.copyWith(id: person!.id));
    } else {
      await personRepository.addPerson(newPerson);
    }
    return true;
  }
}
