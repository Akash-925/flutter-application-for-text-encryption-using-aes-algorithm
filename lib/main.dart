import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'aes_encryption.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TextEncryption AES",
              style: TextStyle(
                fontFamily: "Abel",
                letterSpacing: 2.0,
                wordSpacing: 5.0,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              )),
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: Container(
            height: 550.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                      decoration: InputDecoration(
                        hintText: "Your Text here",
                        border: OutlineInputBorder(),
                      ),
                      toolbarOptions: ToolbarOptions(
                          copy: true, paste: true, selectAll: true),
                      controller: tec,
                      style:
                          TextStyle(fontFamily: "Abel", fontWeight: FontWeight.w400, fontSize: 20)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Original Text",
                      style: TextStyle(
                          fontFamily: "Abel",
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(plainText == null ? "" : plainText),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Plain/Cipher Text",
                      style: TextStyle(
                        fontFamily: "Abel",
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(encryptedText == null
                          ? ""
                          : encryptedText is encrypt.Encrypted
                              ? encryptedText.base64
                              : encryptedText),
                    ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                        ),
                        onPressed: () {
                          plainText = tec.text;
                          setState(() {
                            encryptedText =
                                TextEncryption.encryptAES(plainText);
                          });
                        },
                        child: Text(
                          "Encrypt",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Abel",
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      onPressed: () {
                        setState(() {
                          encryptedText =
                              TextEncryption.decryptAES(encryptedText);
                          print(
                              "Type: " + encryptedText.runtimeType.toString());
                        });
                      },
                      child: Text("Decrypt",
                          style: TextStyle(
                              fontFamily: "Abel",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
