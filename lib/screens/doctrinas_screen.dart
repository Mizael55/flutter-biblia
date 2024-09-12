import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctrinasScreen extends StatelessWidget {
  const DoctrinasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> temas = [
      {'title': 'Diezmo', 'route': 'https://www.facebook.com'},
      {'title': 'Tema 2', 'route': 'https://example.com/tema2'},
      {'title': 'Tema 3', 'route': 'https://example.com/tema3'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Doctrinas')),
      body: ListView.builder(
        itemCount: temas.length,
        itemBuilder: (context, index) {
          final tema = temas[index];
          return ListTile(
            title: Text(tema['title']!),
            onTap: () async {
              final Uri url = Uri.parse(tema['route']!);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not launch ${tema['route']}')),
                );
              }
            },
          );
        },
      ),
    );
  }
}