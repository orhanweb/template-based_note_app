import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final Uint8List audioData;
  final int indexInList;

  const AudioPlayerWidget(
      {Key? key, required this.audioData, required this.indexInList})
      : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioElement _audioElement;
  bool _isPlaying = false;
  bool _isPaused = false;
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    super.initState();
    _audioElement = AudioElement();
    final blob = Blob([widget.audioData], 'audio/mpeg');
    final url = Url.createObjectUrlFromBlob(blob);
    _audioElement.src = url;

    _audioElement.onCanPlay.listen((_) {
      setState(() {
        _duration = _audioElement.duration ?? Duration();
      });
    });

    _audioElement.onTimeUpdate.listen((_) {
      setState(() {
        _position = _audioElement.currentTime ?? Duration();
      });
    });

    _audioElement.onEnded.listen((_) {
      setState(() {
        _isPlaying = false;
        _position = Duration();
      });
    });
  }

  void _playAudio() {
    if (!_isPlaying) {
      _audioElement.play();
      setState(() {
        _isPlaying = true;
        _isPaused = false;
      });
    }
  }

  void _pauseAudio() {
    if (!_isPaused) {
      _audioElement.pause();
      setState(() {
        _isPaused = true;
      });
    }
  }

  void _stopAudio() {
    if (_isPlaying || _isPaused) {
      _audioElement.pause();
      _audioElement.currentTime = 0;
      setState(() {
        _isPlaying = false;
        _isPaused = false;
        _position = Duration();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Anlık Süre: ${_position.toString().split('.').first} / ${_duration.toString().split('.').first}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _audioElement.paused ? _playAudio : _pauseAudio,
                child: Text(_audioElement.paused ? 'Play' : 'Pause'),
              ),
              ElevatedButton(
                onPressed: _stopAudio,
                child: Text('Stop'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
