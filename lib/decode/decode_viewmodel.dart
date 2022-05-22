import 'package:morse_code_app/app/dependencies.dart';
import 'package:morse_code_app/model/decode.dart';
import 'package:morse_code_app/services/decode_data_service.dart';
import 'package:morse_code_app/viewmodel.dart';

class DecodeViewmodel extends Viewmodel {
  Decode? decode;

  DecodeDataService get dataService => service();

  setDecode(Decode decode) {
    this.decode = decode;
  }

  Decode? get decode1 => decode;

  Future<Decode> getDecodeMes(String morseMes, String processedMes) async {
    Decode d1 = await dataService.sendMorseMessage(processedMes);
    d1.morseMessage = morseMes;
    return d1;
  }
}
