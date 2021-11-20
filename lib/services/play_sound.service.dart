import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AppSoundPlayer {
  AudioCache audioCache = AudioCache(prefix: 'assets/sounds/');
  static const enableSoundURI = 'enable.wav';
  static const disableSoundURI = 'disable.wav';
  static const taskDoneSoundURI = 'task_done.wav';
  static const taskRetrieveSoundURI = 'task_retrieve.wav';
  static const taskDeletedSoundURI = 'task_deleted.wav';

  void init() {
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
    audioCache.loadAll([
      enableSoundURI,
      disableSoundURI,
      taskDoneSoundURI,
      taskRetrieveSoundURI,
      taskDeletedSoundURI
    ]);
  }

  void dispose() {
    audioCache.clearAll();
  }

  playSound(String fileName) async {
    audioCache.play(fileName, mode: PlayerMode.LOW_LATENCY);
  }
}
