import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final nomor = TextEditingController();

  _launchURLBrowser(String nomorText) async {
try {
      if (nomorText.startsWith('+')) {
        nomorText = nomorText.substring(1);
      }

      if (nomorText.startsWith('0')) {
        nomorText = '62' + nomorText.substring(1);
      }

      nomorText = nomorText.replaceAll(' ', '');
      nomorText = nomorText.replaceAll('-', '');

      if (!RegExp(r'^[0-9]+$').hasMatch(nomorText)) {
        throw 'Nomor harus berisi angka.';
      }

      var url = Uri.parse("https://wa.me/$nomorText");
      if (!await canLaunch(url.toString())) {
        throw 'Tidak bisa membuka laman $url';
      } else {
        launch(url.toString());
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pertemuan 9'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(40, 70, 40, 0),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Text('M YUSUF SILIHIN', style: TextStyle(fontSize: 30)),
                  const Icon(
                    Icons.mail,
                    size: 75,
                  ),
                  TextField(
                    controller: nomor,
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () => _launchURLBrowser(nomor.text),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: const Color.fromARGB(189, 0, 0, 0),
                        padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                      ),
                      child: const Text(
                        'Kirim',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
