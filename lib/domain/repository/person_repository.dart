import 'package:crud_firebase/domain/models/person.dart';

abstract class PersonRepository {
  Future<List<Person>> getPersons();
  Stream<List<Person>> getPersonsStream();
  Future<Person> addPerson(Person person);
  Future<Person> updatePerson(Person person);
  Future<bool> deletePerson(String id);
}
