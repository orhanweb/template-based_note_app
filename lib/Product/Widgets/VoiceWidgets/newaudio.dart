import 'dart:html';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final Uint8List audioData;
  final int indexInList;

  const AudioPlayerWidget({
    Key? key,
    required this.audioData,
    required this.indexInList,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioElement _audioElement;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  StreamSubscription<Event>? _timeRangesSubscription;

  @override
  void initState() {
    super.initState();
    _audioElement = AudioElement();
    final blob = Blob([widget.audioData], 'audio/webm');
    final url = Url.createObjectUrlFromBlob(blob);
    _audioElement.src = url;
    _audioElement.loop = true;

    _audioElement.onLoadedMetadata.listen((_) {
      print("sdf");
      print("Burada ${_audioElement.readyState}: ${_audioElement.duration}");
      if (_audioElement.readyState >= 2) {
        print("Burada ${_audioElement.readyState}: ${_audioElement.duration}");
        if (_audioElement.duration.isFinite) {
          setState(() {
            _duration = Duration(seconds: _audioElement.duration.toInt());
          });
        } else {
          Future.delayed(Duration(milliseconds: 100), () {
            if (_audioElement.duration.isFinite) {
              setState(() {
                _duration = Duration(seconds: _audioElement.duration.toInt());
              });
            }
          });
        }
      }
    });

    print("Duraton : $_duration");
    _timeRangesSubscription = _audioElement.onTimeUpdate.listen((_) {
      setState(() {
        _position = Duration(seconds: _audioElement.currentTime.toInt());
      });
    });
  }

  @override
  void dispose() {
    _audioElement.pause();
    _timeRangesSubscription?.cancel();
    super.dispose();
  }

  void _play() {
    _audioElement.play();
    setState(() {
      _isPlaying = true;
    });
  }

  void _pause() {
    _audioElement.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _stop() {
    _audioElement.pause();
    _audioElement.currentTime = 0;
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ses ${widget.indexInList + 1}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _isPlaying ? _pause : _play,
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: _stop,
            ),
            Expanded(
              child: Slider(
                value: _position.inSeconds.toDouble(),
                min: 0,
                max: _duration!.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _position = Duration(seconds: value.toInt());
                  });
                  _audioElement.currentTime = _position.inSeconds.toDouble();
                },
              ),
            ),
            Text(
              '${_position.toString().split('.').first}/${_duration.toString().split('.').first}',
            ),
          ],
        ),
      ],
    );
  }
}
