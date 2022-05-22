import 'package:flutter/material.dart';
import 'package:morse_code_app/encode/encode_viewmodel.dart';

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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Form(
                      child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: "Please enter your text",
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        suffixIcon: IconButton(
                            onPressed: (() {}),
                            icon: const Icon(
                              Icons.mic,
                              color: Colors.grey,
                            ))),
                  )),
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
                        onPressed: (() {}),
                        icon: const Icon(
                          Icons.surround_sound,
                          size: 30,
                          color: Colors.grey,
                        ))
                  ],
                ),
                Container(
                    margin: const EdgeInsets.all(5.0),
                    child: (encode != null)
                        ? Text(
                            encode!.encodedMessage.toString(),
                            style: const TextStyle(fontSize: 18),
                          )
                        : const Text(
                            "Morse code here",
                            style: TextStyle(fontSize: 18),
                          )),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: (() async {
                encode = await viewModel.getEncodedMes(textController.text);
                // print(encode!.encodedMessage);
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
    );
  }
}
