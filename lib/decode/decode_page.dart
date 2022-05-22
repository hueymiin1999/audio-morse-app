import 'package:flutter/material.dart';
import 'package:morse_code_app/decode/decode_viewmodel.dart';
import 'package:morse_code_app/model/decode.dart';

class DecodePage extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => const DecodePage());
  const DecodePage({Key? key}) : super(key: key);

  @override
  State<DecodePage> createState() => _DecodePageState();
}

class _DecodePageState extends State<DecodePage> {
  final DecodeViewmodel viewmodel = DecodeViewmodel();
  final morseTextController = TextEditingController();
  Decode? decode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DECODE",
          style: TextStyle(
            fontFamily: "CarterOne",
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: true,
        // leading: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      backgroundColor: const Color.fromARGB(255, 246, 255, 187),
      body: Column(
        children: [
          // Morse code Text Box
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
                    "MORSE CODE TEXT",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Form(
                      child: TextField(
                    controller: morseTextController,
                    decoration: InputDecoration(
                      hintText: "Please enter your text",
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      suffixIcon: IconButton(
                          onPressed: (() async {
                            String mMes = morseTextController.text;
                            String a = mMes.replaceAll(RegExp(r'\s{2,}'), ';');
                            // print(a);
                            String b = a.replaceAll(RegExp(r'\s'), ',');
                            // print(b);
                            decode = await viewmodel.getDecodeMes(mMes, b);
                            setState(() {});
                          }),
                          icon: const Icon(
                            Icons.done,
                            color: Colors.grey,
                            size: 30,
                          )),
                    ),
                  )),
                ),
              ],
            ),
          ),
          // Message Box
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(20.0),
            color: const Color.fromARGB(255, 144, 198, 241),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "TEXT",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: (decode != null)
                      ? Text(
                          decode!.decodedMessage.toString(),
                          style: const TextStyle(fontSize: 18),
                        )
                      : const Text(
                          "Morse code here",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload),
            label: const Text(
              "Upload Audio Files",
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                fixedSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0))),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton.extended(
                label: const Icon(
                  Icons.mic,
                  size: 40,
                ),
                backgroundColor: Colors.amber,
                onPressed: () {}),
          )
        ],
      ),
    );
  }
}
