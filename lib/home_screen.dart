import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _launchURL(Uri uri, bool inApp) async {
    try {
      if (await canLaunchUrl(uri)) {
        if (inApp) {
          await launchUrl(
            uri,
            mode: LaunchMode.inAppWebView,
          );
        } else {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _showLaunchOptions(Uri uri) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Escolha uma opção"),
          content: const Text("Deseja abrir o link no app ou no navegador?"),
          actions: [
            TextButton(
              child: const Text("No app"),
              onPressed: () {
                _launchURL(uri, true);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("No navegador"),
              onPressed: () {
                _launchURL(uri, false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bright Links"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => _showLaunchOptions(Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/')),
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Portal do aluno",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _showLaunchOptions(Uri.parse('https://exemplo.com/educonnect')), // Adicione a URL do Educonnect
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Educonnect (Play Store and App Store)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _showLaunchOptions(Uri.parse('https://exemplo.com/dailyconnect')), // Adicione a URL do Daily Connect
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Daily Connect (Play Store and App Store)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _showLaunchOptions(Uri.parse('https://exemplo.com/toddle')), // Adicione a URL do Toddle
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Toddle (Play Store and App Store)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
