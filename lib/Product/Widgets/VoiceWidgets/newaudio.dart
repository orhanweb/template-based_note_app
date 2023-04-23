import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final Uint8List audioFileBytes;
  final String? title;
  final String? artist;

  AudioPlayerWidget({required this.audioFileBytes, this.title, this.artist});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  void _initAudioPlayer() async {
    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
          children: [memoryFileSource(widget.audioFileBytes)]),
      initialIndex: 0,
      preload: true,
    );
    _audioPlayer.positionStream.listen((event) {
      setState(() {
        _position = event;
      });
    });
    _audioPlayer.durationStream.listen((event) {
      setState(() {
        _duration = event ?? Duration.zero;
      });
    });
    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  String _formatDuration(Duration duration) {
    var minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    var seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: _audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering)
              CircularProgressIndicator()
            else if (!_isPlaying)
              IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 50.0,
                onPressed: _audioPlayer.play,
              )
            else if (processingState != ProcessingState.completed)
              IconButton(
                icon: Icon(Icons.pause),
                iconSize: 50.0,
                onPressed: _audioPlayer.pause,
              )
            else
              IconButton(
                icon: Icon(Icons.replay),
                iconSize: 50.0,
                onPressed: () => _audioPlayer.seek(Duration.zero),
              ),
          ],
        );
      },
    );
  }
}
