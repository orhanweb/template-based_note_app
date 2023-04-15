import 'dart:io';
import 'dart:typed_data';

import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:ekin_app/Product/Utils/Enums/widgets_enum.dart';
import 'package:ekin_app/Product/Widgets/ImageWidgets/Camera_Widget/camera_view.dart';
import 'package:ekin_app/Product/Widgets/ImageWidgets/show_image_view_for_web.dart';
import 'package:ekin_app/Product/Widgets/ImageWidgets/show_image_view_for_mobile.dart';
import 'package:ekin_app/Product/Widgets/TextInputWidget/text_input_widget.dart';
import 'package:ekin_app/Product/Widgets/VoiceWidgets/newaudio.dart';
import 'package:ekin_app/Product/Widgets/VoiceWidgets/record_audio_view.dart';
import 'package:ekin_app/Product/Widgets/VoiceWidgets/audio_player_view.dart';
import 'package:ekin_app/Product/Widgets/VoiceWidgets/sound_base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../Product/Widgets/MultipleAnswerWidget/multiple_anser_widget_view.dart';

class NewRegCubit extends Cubit<List<NewRegModel>> {
  NewRegCubit() : super([]);

  // Add Text Widget to New Reg List
  void addTextWidget({required String labelText}) {
    state.add(NewRegModel(
        indexinList: state.length,
        widgetType: WhichWidget.text,
        widget: TextinputWidget(
          labelText: labelText,
        )));
    final newState = List<NewRegModel>.from(state);
    emit(newState);
  }

  // Add Voice Recorder Widget to New Reg(Note) List
  void addVoiceRecorderWidget() {
    state.add(NewRegModel(
        indexinList: state.length,
        widgetType: WhichWidget.voiceRecorder,
        widget: RecordAudioWidget(
          indexinList: state.length,
        )));
    final newState = List<NewRegModel>.from(state);
    emit(newState);
  }

  // Add Audio Player to New Reg List
  void addAudioPlayerWidget(
      {required int indexinList, required Uint8List audioBytes}) {
    if (audioBytes.isNullOrEmpty) return;
    state.removeAt(indexinList);
    state.insert(
        indexinList,
        NewRegModel(
          indexinList: indexinList,
          widgetType: WhichWidget.audioPlayer,
          widget: AudioPlayerWidget(
            audioData: audioBytes,
            indexInList: indexinList,
          ),
        ));

    final newState = List<NewRegModel>.from(state);
    emit(newState);
  }

  // Add Multiple Choice Widget to New Reg List
  void addMultipleAnserWidget() {
    state.add(NewRegModel(
        indexinList: state.length,
        widgetType: WhichWidget.multipleAnswer,
        widget: MultipleAnserView(
          indexinList: state.length,
        )));
    final newState = List<NewRegModel>.from(state);
    emit(newState);
  }

  // Add Camera Widget to New Reg List
  void addCameraWidget() {
    final newState = List<NewRegModel>.from(state);
    newState.add(NewRegModel(
        indexinList: state.length,
        widgetType: WhichWidget.camera,
        widget: CameraView(indexinList: state.length)));
    emit(newState);
  }

  // Add Show Image Widget to New Reg List
  void addShowimageWidget({File? image, required int indexinList}) {
    if (image != null) {
      state.removeAt(indexinList);
      state.insert(
          indexinList,
          NewRegModel(
            indexinList: indexinList,
            widgetType: WhichWidget.image,
            widget: ShowImageView(image: image, indexinList: indexinList),
          ));

      final newState = List<NewRegModel>.from(state);
      emit(newState);
    }
  }

  // Add Show Image Widget to New Reg List for Web
  void addShowimageForWeb({Uint8List? imageBytes, required int indexinList}) {
    if (imageBytes != null) {
      state.removeAt(indexinList);
      state.insert(
          indexinList,
          NewRegModel(
            indexinList: indexinList,
            widgetType: WhichWidget.image,
            widget: ShowImageViewWeb(
                imageBytes: imageBytes, indexinList: indexinList),
          ));

      final newState = List<NewRegModel>.from(state);
      emit(newState);
    }
  }

  // Add Camera widget back and remove Show image widget
  void backtoCameraWidget({required int indexinList}) {
    state.removeAt(indexinList);
    state.insert(
        indexinList,
        NewRegModel(
            indexinList: indexinList,
            widgetType: WhichWidget.camera,
            widget: CameraView(indexinList: indexinList)));
    final newState = List<NewRegModel>.from(state);
    emit(newState);
  }

  //  Remove Camera Widget with onLongPress ---- Doesnt Work for Now
  void removeCameraWidget({required int indexinList}) {
    state.removeAt(indexinList);
    final newState = List<NewRegModel>.from(state);
    emit(newState);
  }
}
