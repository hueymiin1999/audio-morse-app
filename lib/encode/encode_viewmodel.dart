import 'dart:io';
import 'package:morse_code_app/model/audio_morse.dart';
import 'package:path_provider/path_provider.dart';

import 'package:morse_code_app/model/encode.dart';
import 'package:morse_code_app/services/encode_data_service.dart';
import 'package:morse_code_app/viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/dependencies.dart';

class EncodeViewModel extends Viewmodel {
  Encode? encode;

  EncodeDataService get dataService => service();

  setEncode(Encode encode) {
    this.encode = encode;
  }

  Encode? get encode1 => encode;

  Future<Encode> getEncodedMes(String textMes) async {
    //turnBusy();
    Encode e1 = await dataService.sendTextMessage(textMes);
    String? changedMes = e1.encodedMessage;
    changedMes = changedMes!.replaceAll("/", " ");
    changedMes = changedMes.replaceAll(";", "   ");
    //print("changed message = " + changedMes);
    e1.changedMessage = changedMes;

    return e1;
    //turnIdle();
  }

  Future<AudioMorse> playMorseSound(String m) async {
    int speed;
    int freq;

    // get shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.containsKey("frequency")
        ? freq = prefs.getInt("frequency")!
        : freq = 100;

    prefs.containsKey("speed") ? speed = prefs.getInt("speed")! : speed = 20;

    final response = await dataService.playMorseSound(
      morse: m,
      freq: freq,
      speed: speed,
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/sound.wav');
    await file.writeAsBytes(response.bodyBytes);
    return AudioMorse(audioFile: file, path: file.path);
  }
}
