import 'package:biblia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class LiricsSongsScreen extends StatelessWidget {
  final bool coro;

  const LiricsSongsScreen({super.key, required this.coro});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: theme == ThemeData.dark() ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectedRoutes(),
              ),
            );
          },
        ),
        title: Text(coro ? 'Coros - Harmonia' : 'Himnario',
            style: TextStyle(
                color: theme == ThemeData.dark() ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
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
    );
  }
}
