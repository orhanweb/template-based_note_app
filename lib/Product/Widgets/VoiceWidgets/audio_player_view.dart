import 'dart:async';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView(
      {super.key,
      required this.audioPath,
      required this.indexinList,
      required this.audioDuration});
  final String audioPath;
  final int audioDuration;
  final int indexinList;
  @override
  State<AudioPlayerView> createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  late final AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isLoad = false;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    setAudio();
  }

  void _onPlayerStateChanged(PlayerState state) {
    setState(() {
      isPlaying = state == PlayerState.playing;
    });
  }

  void _onPositionChanged(Duration newPosition) {
    setState(() {
      position = newPosition;
    });
  }

  Future<void> setAudio() async {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.setSourceDeviceFile(widget.audioPath);
    _audioPlayer.onPlayerStateChanged.listen(_onPlayerStateChanged);

    _audioPlayer.onPositionChanged.listen(_onPositionChanged);
    setState(() {
      isLoad = true;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: context.colorScheme.inversePrimary,
            borderRadius: AppRadius.radius12Circular),
        child: Column(
          children: [
            Padding(
                padding: kPaddingTopSmall,
                child: !isLoad
                    ? const LinearProgressIndicator()
                    : Slider(
                        value: position.inSeconds.toDouble(),
                        max: widget.audioDuration.toDouble(),
                        onChanged: (value) async {
                          await _audioPlayer.stop();
                          await _audioPlayer
                              .seek(Duration(seconds: value.toInt()));
                          await _audioPlayer.resume();
                        },
                      )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(child: Center(child: Text(formatDuration(position)))),
              const Spacer(flex: 2),
              Expanded(
                  child: Center(
                      child: Text(formatDuration(
                          Duration(seconds: widget.audioDuration)))))
            ]),
            IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await _audioPlayer.pause();
                  } else {
                    await _audioPlayer.resume();
                  }
                },
                icon: isPlaying
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow))
          ],
        ));
  }
}
