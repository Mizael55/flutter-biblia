import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diacritic/diacritic.dart'; // Importa la biblioteca para eliminar acentos
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filterFullBible = Provider.of<BookProviders>(context).fullBible;
    final letterSize = Preferences.getSize;

    if (filterFullBible.isEmpty) {
      Provider.of<BookProviders>(context).readAllJson();
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

    // Filtrar los versículos según el texto de búsqueda
    final filteredBible = filterFullBible.where((data) {
      final text = removeDiacritics(data['Text'].toString().toLowerCase());
      final searchText = removeDiacritics(searchQuery.toLowerCase());
      return text.contains(searchText);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Buscar...',
            hintStyle: TextStyle(fontSize: letterSize),
          ),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: filteredBible.length,
        itemBuilder: (context, index) {
          final item = filteredBible[index];
          return ListTile(
            title: Text(
              '${item['Book']} ${item['Chapter']}:${item['Verse']}',
              style:
                  TextStyle(fontSize: letterSize, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item['Text'],
              style: TextStyle(fontSize: letterSize),
            ),
          );
        },
      ),
    );
  }
}
