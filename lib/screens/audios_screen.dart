import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioScreen extends StatefulWidget {
  final int titleNumber;

  const AudioScreen({super.key, required this.titleNumber});
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _audioFilesKoinonia = [
    'audios/koinonia/1.mp3',
    'audios/koinonia/2.mp3',
    'audios/koinonia/3.mp3',
    'audios/koinonia/4.mp3',
    'audios/koinonia/5.mp3',
    'audios/koinonia/6.mp3',
    'audios/koinonia/7.mp3',
    'audios/koinonia/8.mp3',
    'audios/koinonia/9.mp3',
    'audios/koinonia/10.mp3',
    'audios/koinonia/11.mp3',
    'audios/koinonia/12.mp3',
    'audios/koinonia/13.mp3',
    'audios/koinonia/14.mp3',
  ];
  final List<String> _audioFilesEnviados = [
    'audios/enviados/1.mp3',
    'audios/enviados/2.mp3',
    'audios/enviados/3.mp3',
    'audios/enviados/4.mp3',
    'audios/enviados/5.mp3',
    'audios/enviados/6.mp3',
    'audios/enviados/7.mp3',
    'audios/enviados/8.mp3',
    'audios/enviados/9.mp3',
    'audios/enviados/10.mp3',
    'audios/enviados/11.mp3',
    'audios/enviados/12.mp3',
    'audios/enviados/13.mp3',
    'audios/enviados/14.mp3',
  ];
  final List<String> _audioFilesVoces = [
    'audios/voces/1.mp3',
    'audios/voces/2.mp3',
    'audios/voces/3.mp3',
    'audios/voces/4.mp3',
    'audios/voces/5.mp3',
    'audios/voces/6.mp3',
    'audios/voces/7.mp3',
    'audios/voces/8.mp3',
    'audios/voces/9.mp3',
    'audios/voces/10.mp3',
    'audios/voces/11.mp3',
    'audios/voces/12.mp3',
    'audios/voces/13.mp3',
    'audios/voces/14.mp3',
  ];
  final List<String> _namesKoinonia = [
    'La bondad de Dios',
    'Amor tan grande',
    'Unidos',
  ];
  final List<String> _namesEnviados = [
    'no hay',
    'no hay',
    'nada',
  ];
  final List<String> _namesVoces = [
    'no hay',
    'no hay',
    'nada',
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
    await _audioPlayer.play(AssetSource(widget.titleNumber == 1
        ? _audioFilesKoinonia[_currentIndex]
        : widget.titleNumber == 2
            ? _audioFilesEnviados[_currentIndex]
            : _audioFilesVoces[_currentIndex]));
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
    int maxIndex = widget.titleNumber == 1
        ? _audioFilesKoinonia.length - 1
        : widget.titleNumber == 2
            ? _audioFilesEnviados.length - 1
            : _audioFilesVoces.length - 1;

    if (_currentIndex < maxIndex) {
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
      appBar: AppBar(
        centerTitle: true,
        actions: [
          // has que aparezca la lista de de canciones desplegando un menu
          PopupMenuButton(
            itemBuilder: (context) {
              return List.generate(
                  widget.titleNumber == 1
                      ? _namesKoinonia.length
                      : widget.titleNumber == 2
                          ? _namesEnviados.length
                          : _namesVoces.length, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text(widget.titleNumber == 1
                      ? _namesKoinonia[index]
                      : widget.titleNumber == 2
                          ? _namesEnviados[index]
                          : _namesVoces[index]),
                );
              });
            },
            onSelected: (index) async {
              await _stopAudio();
              setState(() {
                _currentIndex = index;
              });
              await _playAudio();
            },
          ),
        ],
        title: () {
          switch (widget.titleNumber) {
            case 1:
              return Text("KOINONIA IDC");
            case 2:
              return Text("Los enviados de Dios");
            case 3:
              return Text("Voces de las iglesias");
            default:
              return Text("KOINONIA IDC");
          }
        }(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.titleNumber == 1
                  ? _namesKoinonia[_currentIndex]
                  : widget.titleNumber == 2
                      ? _namesEnviados[_currentIndex]
                      : _namesVoces[_currentIndex],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: widget.titleNumber == 1
                    ? _audioFilesKoinonia.length
                    : widget.titleNumber == 2
                        ? _audioFilesEnviados.length
                        : _audioFilesVoces.length,
                controller: PageController(initialPage: _currentIndex),
                onPageChanged: (index) async {
                  await _stopAudio();
                  setState(() {
                    _currentIndex = index;
                  });
                  await _playAudio();
                },
                itemBuilder: (context, index) {
                  Widget image;
                  switch (widget.titleNumber) {
                    case 1:
                      image = Image.asset(
                        'assets/img/koinonia.jpeg',
                        fit: BoxFit.cover,
                      );
                      break;
                    case 2:
                      image = Image.asset(
                        'assets/img/enviados.jpg',
                        fit: BoxFit.cover,
                      );
                      break;
                    case 3:
                      image = Image.asset(
                        'assets/img/voces.jpg',
                        fit: BoxFit.cover,
                      );
                      break;
                    default:
                      image = Image.asset(
                        'assets/img/koinonia.jpeg',
                        fit: BoxFit.cover,
                      );
                  }
                  return Center(
                    child: ClipOval(
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        child: image,
                      ),
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
              "Audio ${_currentIndex + 1} de ${widget.titleNumber == 1 ? _audioFilesKoinonia.length : widget.titleNumber == 2 ? _audioFilesEnviados.length : _audioFilesVoces.length}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
