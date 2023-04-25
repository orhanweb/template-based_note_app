import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';
import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:ekin_app/Product/Utils/Enums/widget_enum.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PlayerAudioWidget extends StatefulWidget {
  final Uint8List audioData;
  final int indexinList;
  final int audioLenght;

  const PlayerAudioWidget(
      {Key? key,
      required this.audioData,
      required this.indexinList,
      required this.audioLenght})
      : super(key: key);

  @override
  State<PlayerAudioWidget> createState() => _PlayerAudioWidgetState();
}

class _PlayerAudioWidgetState extends State<PlayerAudioWidget> {
  late final AudioElement _audioElement;
  bool _isPlaying = false;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPaddingAllSmall,
      decoration: BoxDecoration(
          borderRadius: AppRadius.radius12Circular,
          color: context.colorScheme.inversePrimary),
      height: ProjectWidgetEnums.playerAudioWidgetHeigth.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ses ${widget.indexinList + 1}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _isPlaying ? _pause : _play,
              ),
              Expanded(
                child: Slider(
                  value: _position.inSeconds.toDouble(),
                  min: 0,
                  max: (widget.audioLenght.toDouble() - 1),
                  onChanged: (value) {
                    setState(() {
                      _position = Duration(seconds: value.toInt());
                    });
                    _audioElement.currentTime = _position.inSeconds.toDouble();
                  },
                ),
              ),
              Text(
                '${_position.toString().split('.').first}/${Duration(seconds: widget.audioLenght).toString().split('.').first}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
