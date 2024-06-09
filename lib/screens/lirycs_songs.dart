import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../widgets/widgets.dart';

class LiricsSongsScreen extends StatelessWidget {
  final bool coro;

  const LiricsSongsScreen({super.key, required this.coro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: const Text('Canciones'),
        actions: [
          IconButton(
            icon: coro ? const Icon(Icons.book) : const Icon(Icons.music_note),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiricsSongsScreen(
                    coro: !coro,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            height: 700, // specify the height
            child: PDF(
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              defaultPage: 1,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
              },
            ).fromAsset(
              coro ? 'assets/coro.pdf' : 'assets/himnario.pdf',
            ),
          ),
        ),
      ),
    );
  }
}
