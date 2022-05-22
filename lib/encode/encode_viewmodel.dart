import 'package:morse_code_app/model/encode.dart';
import 'package:morse_code_app/services/encode_data_service.dart';
import 'package:morse_code_app/viewmodel.dart';

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
    // print(e1.encodedMessage);
    return e1;
    //turnIdle();
  }
}
