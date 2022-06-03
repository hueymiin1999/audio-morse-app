class Decode {
  String? morseMessage;
  String? processedMorse;
  String? decodedMessage;

  Decode({required this.morseMessage, required this.decodedMessage});

  Decode.fromJson(Map<String, dynamic> json)
      : this(
            morseMessage: json['processedMes'],
            decodedMessage: json['decodedMes']);

  Map<String, dynamic> toJson() => {
        'processedMes': processedMorse,
        'decodedMes': decodedMessage,
      };

  void getMorseMes() {
    String morse = morseMessage!.replaceAll('/', ' ');
    processedMorse = morse.replaceAll(';', '   ');
  }
}
