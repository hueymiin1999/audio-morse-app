import 'package:morse_code_app/model/encode.dart';

import 'rest_service.dart';

class EncodeDataService {
  static final EncodeDataService _instance = EncodeDataService._constructor();

  factory EncodeDataService() {
    return _instance;
  }

  EncodeDataService._constructor();
  final rest = RestService();

  Future<Encode> sendTextMessage(String textMes) async {
    final json = await rest.get('/encode/$textMes');

    return Encode.fromJson(json);
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
  // Future<List<Bank>> getBankList() async {
  //   final listJson = await rest.get('bank');

  //   return (listJson as List)
  //       .map((itemJson) => Bank.fromJson(itemJson))
  //       .toList();
  // }

  // Future<Bank> getBankInfo({String userEmail}) async {
  //   final bank = await rest.get('bank?userId=$userEmail');

  //   return (bank).map((itemJson) => Bank.fromJson(itemJson));
  // }
}
