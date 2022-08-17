import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:flutter/material.dart';

class ListRealtimeProvider extends ChangeNotifier {
  ListRealtimeProvider({required this.personRepository});

  final PersonRepository personRepository;

  Stream<List<Person>> load() => personRepository.getPersonsStream();

  void delete(String docId) async {
    await personRepository.deletePerson(docId);
  }
}
