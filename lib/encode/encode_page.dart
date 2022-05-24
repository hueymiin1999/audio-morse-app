import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:morse_code_app/encode/encode_viewmodel.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../model/audio_morse.dart';
import '../model/encode.dart';

class EncodePage extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => const EncodePage());
  const EncodePage({Key? key}) : super(key: key);

  @override
  State<EncodePage> createState() => _EncodePageState();
}

class _EncodePageState extends State<EncodePage> {
  final EncodeViewModel viewModel = EncodeViewModel();
  final textController = TextEditingController();
  Encode? encode;
  AudioMorse? audioMorse;
  late AudioPlayer player;

  late stt.SpeechToText _speech;
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int maxline = 3;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Encode",
          style: TextStyle(fontFamily: "CarterOne", fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: true,
        //leading: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      backgroundColor: const Color.fromARGB(255, 246, 255, 187),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text Box
            Container(
              margin: const EdgeInsets.all(20.0),
              color: const Color.fromARGB(255, 131, 230, 204),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "TEXT",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    height: maxline * 30,
                    child: TextField(
                      controller: textController,
                      maxLines: maxline,
                      style: const TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 22),
                        hintText: "Please enter your text",
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        suffixIcon: GestureDetector(
                          child: AvatarGlow(
                            endRadius: 30.0,
                            animate: isListening,
                            glowColor: Colors.redAccent,
                            duration: const Duration(milliseconds: 2000),
                            repeatPauseDuration:
                                const Duration(milliseconds: 100),
                            repeat: true,
                            child: Icon(
                                isListening ? Icons.mic : Icons.mic_none,
                                color: isListening ? Colors.red : Colors.grey),
                          ),
                          onLongPress: () {
                            setState(() {
                              listen();
                            });
                            //print("start");
                          },
                          onLongPressUp: () {
                            //print("end");
                            setState(() {
                              isListening = false;
                            });
                            _speech.stop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Morse code Box
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(20.0),
              color: const Color.fromARGB(255, 144, 198, 241),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "MORSE CODE",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: (() async {
                            String morse;
                            if (encode?.encodedMessage != null ||
                                encode?.encodedMessage == "") {
                              morse = encode!.encodedMessage.toString();

                              audioMorse =
                                  await viewModel.playMorseSound(morse);
                              await player
                                  .setFilePath(audioMorse!.path.toString());
                              player.play();
                            } else {
                              AlertDialog alert = AlertDialog(
                                title: const Text("Error!"),
                                content: const Text(
                                    "Plaese make sure you have encode the text."),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Okay")),
                                ],
                              );

                              showDialog(
                                  context: context,
                                  builder: (BuildContext cotext) {
                                    return alert;
                                  });
                            }
                          }),
                          icon: const Icon(
                            Icons.surround_sound,
                            size: 30,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      height: maxline * 30,
                      child: (encode != null)
                          ? Text(
                              encode!.changedMessage.toString(),
                              style: const TextStyle(fontSize: 30),
                            )
                          : const Text(
                              "Morse code here",
                              style: TextStyle(fontSize: 22),
                              maxLines: maxline,
                            )),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: (() async {
                  encode = await viewModel.getEncodedMes(textController.text);
                  //print(encode!.encodedMessage);
                  setState(() {});
                }),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    fixedSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0))),
                child: const Text(
                  "ENCODE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }

  void listen() async {
    if (!isListening) {
      bool avail = await _speech.initialize();
      if (avail) {
        setState(() {
          isListening = true;
        });
        _speech.listen(onResult: (value) {
          setState(() {
            textController.text = value.recognizedWords;
          });
        });
      }
    }
  }
}
