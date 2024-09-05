import 'package:biblia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CorosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coros = Provider.of<CorosProvider>(context).coros;

    if (coros.isEmpty) {
      Provider.of<CorosProvider>(context).getCoros();
      return const Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cargando...'),
            CircularProgressIndicator(backgroundColor: Colors.indigo),
          ],
        )),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coros'),
      ),
      body: ListView.builder(
        itemCount: coros.length,
        itemBuilder: (context, index) {
          final data = coros[index];
          return ListTile(
            title: ExpansionTile(
              title: Text(
                '${index + 1}. ${data['titulo']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                if (data['autor'] != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Autor: ${data['autor']}',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ),
                if (data['estrofas'] != null && data['estrofas'] is List) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Estrofas:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...data['estrofas'].map<Widget>((line) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        line,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ],
                if (data['coro'] != null && data['coro'] is List) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Coro:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...data['coro'].map<Widget>((line) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        line,
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    );
                  }).toList(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
