import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class SongDetailScreen extends StatelessWidget {
  final Song song;

  SongDetailScreen({required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (song.author != null)
                  Text(
                    'Author: ${song.author}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: 16),
                ...song.verses.map((verse) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (verse.verse != null)
                          Text(
                            verse.verse!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        SizedBox(height: 8),
                        Text(
                          verse.text,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        if (verse.chorus != null) ...[
                          SizedBox(height: 8),
                          Text(
                            'Coro',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            verse.chorus!,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: 16),
                AdmobBanner(
                  adUnitId: "ca-app-pub-7568006196201830/2419923083",
                  adSize: AdmobBannerSize.BANNER,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}