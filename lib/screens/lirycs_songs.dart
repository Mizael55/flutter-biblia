import 'package:flutter/material.dart';

class LiricsSongsScreen extends StatelessWidget {
  const LiricsSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canciones'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Cancion $index'),
            onTap: () {
              Navigator.pushNamed(context, '/lyrics');
            },
          );
        },
      ),
    );
  }
}
