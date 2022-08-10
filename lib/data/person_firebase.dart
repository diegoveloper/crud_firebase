import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';

class PersonFirebase implements PersonRepository {
  final personRef =
      FirebaseFirestore.instance.collection('persons').withConverter<Person>(
            fromFirestore: (snapshots, _) {
              final person = Person.fromJson(snapshots.data()!);
              final newPerson = person.copyWith(id: snapshots.id);
              return newPerson;
            },
            toFirestore: (person, _) => person.toJson(),
          );

  @override
  Future<List<Person>> getPersons() async {
    final querySnapshot = await personRef.get();
    final persons = querySnapshot.docs.map((e) => e.data()).toList();
    return persons;
  }

  @override
  Future<bool> addPerson(Person person) async {
    await personRef.add(person);
    return true;
  }

  @override
  Future<bool> deletePerson(String id) async {
    await personRef.doc(id).delete();
    return true;
  }

  @override
  Future<bool> updatePerson(Person person) async {
    await personRef.doc(person.id).update(person.toJson());
    return true;
  }
}
