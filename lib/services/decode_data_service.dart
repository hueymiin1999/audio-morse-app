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

  Future<Decode> decodeAudioMorse(String path, String filename) async {
    final json = await rest.postAudio('/decode_audio', path, filename);
    return Decode.fromJson(json);
  }

  Future playMorseSound(
      {required String morse, required int freq, required int speed}) async {
    final response = await rest.postFile('/play_morse_audio', data: {
      "morse": morse,
      "freq": freq,
      "speed": speed,
    });
    return response;
  }
}
