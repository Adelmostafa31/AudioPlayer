// ignore_for_file: avoid_print

import 'dart:io';

import 'package:audio_player/Bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class audioBloc extends Cubit<audioStates> {
  audioBloc() : super(AudioItialSate());

  static audioBloc get(context) => BlocProvider.of(context);

  FlutterSoundRecorder recoder = FlutterSoundRecorder();
  FlutterSoundPlayer player = FlutterSoundPlayer();
  String path = '';
  Future<void> startRecord() async {
    Permission.microphone.request();
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      try {
        await recoder.openRecorder();
        Directory? directory = await getExternalStorageDirectory();
        path = '${directory!.path}/audioPlayer.aac';
        await recoder.startRecorder(toFile: path);
        emit(STARecord());
      } catch (error) {
        print(error.toString());
      }
    } else {
      print('object');
    }
  }

  Future<void> stopRecord() async {
    try {
      await recoder.stopRecorder();
      await recoder.closeRecorder();
      emit(STPRecord());
      path = path;
      emit(state);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> playRecord() async {
    try {
      await player.openPlayer();
      await player.startPlayer(fromURI: path);
      emit(STRPlay());
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> stopPlayRecord() async {
    try {
      await player.closePlayer();
      await player.stopPlayer();
      emit(STPPlay());
    } catch (error) {
      print(error.toString());
    }
  }
}
