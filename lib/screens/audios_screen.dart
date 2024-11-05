import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _audioFiles = [
    'audio/1.mp3',
    'audio/2.mp3',
    'audio/3.mp3',
    'audio/4.mp3',
    'audio/5.mp3',
    'audio/6.mp3',
    'audio/7.mp3',
    'audio/8.mp3',
    'audio/9.mp3',
    'audio/10.mp3',
    'audio/11.mp3',
    'audio/12.mp3',
    'audio/13.mp3',
    'audio/14.mp3',
  ];
  final List<String> _names = [
    'La bondad de Dios',
    'Amor tan grande',
    'Unidos',
  ];
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  late AdmobInterstitial interstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-7568006196201830/3482519473",
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.loaded) {
          if (!_isAdLoaded) {
            interstitialAd.show();
            setState(() {
              _isAdLoaded = true;
            });
          }
        }
      },
    );

    interstitialAd.load();

    // Escucha los cambios en la duración y posición del audio
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      _playNextAudio();
    });
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource(_audioFiles[_currentIndex]));
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  Future<void> _playNextAudio() async {
    if (_currentIndex < _audioFiles.length - 1) {
      setState(() {
        _currentIndex++;
      });
      await _playAudio();
    } else {
      _stopAudio();
    }
  }

  Future<void> _playPreviousAudio() async {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      await _playAudio();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Coro acapella KOINONIA IDC")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _names[_currentIndex],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: _audioFiles.length,
                controller: PageController(initialPage: _currentIndex),
                onPageChanged: (index) async {
                  await _stopAudio();
                  setState(() {
                    _currentIndex = index;
                  });
                  await _playAudio();
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.asset(
                      'assets/img/koinonia.jpeg',
                      width: 300,
                      height: 300,
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              child: AdmobBanner(
                adUnitId: "ca-app-pub-7568006196201830/2419923083",
                adSize: AdmobBannerSize.BANNER,
              ),
            ),
            Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await _audioPlayer.seek(position);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_position)),
                Text(_formatDuration(_duration)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 32),
                  onPressed: _playPreviousAudio,
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    size: 64,
                  ),
                  onPressed: _isPlaying ? _pauseAudio : _playAudio,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 32),
                  onPressed: _playNextAudio,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Audio ${_currentIndex + 1} de ${_audioFiles.length}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
