import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';

class PersonLocal implements PersonRepository {
  @override
  Future<List<Person>> getPersons() async {
    return List.generate(
      10,
      (index) => Person(
          name: 'Diego$index', lastname: 'Velasquez$index', gender: 'M$index'),
    );
  }

  @override
  Future<bool> addPerson(Person person) {
    // TODO: implement addPerson
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePerson(String id) {
    // TODO: implement deletePerson
    throw UnimplementedError();
  }

  @override
  Future<bool> updatePerson(Person person) {
    // TODO: implement updatePerson
    throw UnimplementedError();
  }
}
