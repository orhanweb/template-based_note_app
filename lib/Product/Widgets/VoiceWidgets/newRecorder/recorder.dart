import 'dart:async';
import 'dart:developer';
import 'dart:html';
import 'dart:typed_data';

import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewRecorder extends StatefulWidget {
  const NewRecorder({super.key, required this.indexInList});
  final int indexInList;
  @override
  State<NewRecorder> createState() => _NewRecorderState();
}

class _NewRecorderState extends State<NewRecorder> {
  final AudioRecorder _audioRecorder = AudioRecorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: BlocBuilder<NewRegCubit, List<NewRegModel>>(
          builder: (context, state) {
            return ElevatedButton(
                onPressed: _audioRecorder.isRecording
                    ? () async {
                        _audioRecorder
                            .stopRecording()
                            .then((bytes) => print(bytes));
                        setState(() {});

                        // context.read<NewRegCubit>().addAudioPlayerWidget(indexinList: widget.indexInList, audioDuration: audioDuration)
                      }
                    : () async {
                        await _audioRecorder.startRecording();
                        setState(() {});
                      },
                child: _audioRecorder.isRecording
                    ? Text("Kaydı Durdur")
                    : Text("Kaydı Başlat"));
          },
        ),
      ),
    );
  }
}

class AudioRecorder {
  MediaStream? _stream;
  MediaRecorder? _recorder;
  List<Uint8List> _chunks = [];
  bool isRecording = false;

  Future<void> startRecording() async {
    try {
      _stream =
          await window.navigator.mediaDevices?.getUserMedia({'audio': true});

      if (_stream == null) {
        throw Exception('Failed to get user media stream');
      }

      _recorder = MediaRecorder(_stream!);
      _recorder!.addEventListener('dataavailable', (event) async {
        final reader = FileReader();
        reader.readAsArrayBuffer((event as BlobEvent).data!);

        await reader.onLoad.first;
        final buffer = reader.result as Uint8List?;

        if (buffer == null) {
          throw Exception('Failed to read data available from media recorder');
        }

        _chunks.add(buffer);
      });

      _recorder!.start();
      isRecording = true;
    } catch (e) {
      print('Error while starting audio recording: $e');
      rethrow;
    }
  }

  Future<Uint8List> stopRecording() async {
    try {
      if (_recorder == null) {
        throw Exception('Media recorder is not available');
      }

      _recorder!.stop();
      _stream?.getTracks().forEach((track) => track.stop());
      isRecording = false;

      if (_chunks.isEmpty) {
        throw Exception('No data available to stop audio recording');
      }

      final bytes =
          Uint8List.fromList(_chunks.expand((chunk) => chunk).toList());
      _chunks.clear();

      return bytes;
    } catch (e) {
      print('Error while stopping audio recording: $e');
      rethrow;
    }
  }
}
