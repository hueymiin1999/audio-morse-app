import 'dart:io';

import 'package:morse_code_app/model/decode.dart';

import 'rest_service.dart';

class DecodeDataService {
  static final DecodeDataService _instance = DecodeDataService._constructor();

  factory DecodeDataService() {
    return _instance;
  }

  DecodeDataService._constructor();
  final rest = RestService();

  Future<Decode> sendMorseMessage(String processMes) async {
    final json = await rest.get('/decode_text/$processMes');

    return Decode.fromJson(json);
  }

  Future<void> decodeAudioMorse(String path) async {
    await rest.postAudio('/read_audio', path);
  }
}
