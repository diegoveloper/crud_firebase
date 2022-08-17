import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:crud_firebase/ui/features/realtime/add_screen.dart';
import 'package:crud_firebase/ui/features/realtime/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRealtimeScreen extends StatefulWidget {
  const ListRealtimeScreen._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => ListRealtimeProvider(
          personRepository: context.read<PersonRepository>(),
        )..load(),
        child: const ListRealtimeScreen._(),
      );

  @override
  State<ListRealtimeScreen> createState() => _ListRealtimeScreenState();
}

class _ListRealtimeScreenState extends State<ListRealtimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<Person>>(
          stream: context.read<ListRealtimeProvider>().load(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            if (data.isEmpty) {
              return const Center(
                child: Text('Empty list'),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final person = data[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AddScreen.init(person: person),
                      ),
                    );
                  },
                  onLongPress: () {
                    context.read<ListRealtimeProvider>().delete(person.id!);
                  },
                  title: Text('${person.name} ${person.lastname}'),
                  subtitle: Text(person.gender),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push<Person?>(
            MaterialPageRoute(
              builder: (_) => AddScreen.init(),
            ),
          );
        },
      ),
    );
  }
}
