import 'package:biblia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CorosScreen extends StatefulWidget {
  @override
  _CorosScreenState createState() => _CorosScreenState();
}

class _CorosScreenState extends State<CorosScreen> {
  String searchQuery = '';

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

    final filteredCoros = coros.where((coro) {
      final titulo = coro['titulo'].toLowerCase();
      final autor = coro['autor']?.toLowerCase() ?? '';
      final query = searchQuery.toLowerCase();
      return titulo.contains(query) || autor.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coros'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredCoros.length,
        itemBuilder: (context, index) {
          final data = filteredCoros[index];
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
