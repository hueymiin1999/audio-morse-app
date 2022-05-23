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
    String? changedMes = e1.encodedMessage;
    changedMes = changedMes!.replaceAll("/", " ");
    changedMes = changedMes.replaceAll(";", "   ");
    print("changed message = " + changedMes);
    e1.encodedMessage = changedMes;

    return e1;
    //turnIdle();
  }

  Future<String?> changeFormat(String rawMes) async {
    String? changedMes = "a" + " a" + "   a" + "    a";
    print(changedMes);
    return changedMes;
  }
}
