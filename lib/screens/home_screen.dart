import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chapter = Provider.of<BooksNamesProvider>(context).chapter;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: Text('${chapter['name']} ${chapter['chapter']}'),
      ),
      drawer: const DrawerScreen(),
      body: ListView.builder(
        itemCount: chapter['vers'].length,
        itemBuilder: (context, index) {
          final verse = chapter['vers'][index];
          return ListTile(
            title: Text('${verse['number']}: ${verse['verse']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat_rounded),
      ),
    );
  }
}
