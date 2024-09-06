// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/providers.dart';
// import '../share_preferences/preferences.dart';

// class SearchScreen extends StatefulWidget {
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   String searchQuery = '';
//   List<dynamic> filteredChapter = [];

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(() {
//       setState(() {
//         searchQuery = _searchController.text.toLowerCase();
//         if (searchQuery.isNotEmpty) {
//           Provider.of<BookProviders>(context, listen: false)
//               .loadAllTheTextAreIgualToParameter(searchQuery)
//               .then((result) {
//             setState(() {
//               filteredChapter = result;
//             });
//           });
//         } else {
//           filteredChapter = [];
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final letterSize = Preferences.getSize;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Buscar'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(kToolbarHeight),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Buscar...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                 ),
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: filteredChapter.isEmpty
//           ? Center(child: Text('No hay resultados'))
//           : ListView.builder(
//               controller: _scrollController,
//               itemCount: filteredChapter.length,
//               itemBuilder: (context, index) {
//                 final data = filteredChapter[index];
//                 return ListTile(
//                   title: Text(
//                     data['text'],
//                     style: TextStyle(fontSize: letterSize),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }