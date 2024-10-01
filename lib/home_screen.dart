import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    
    // Solicitar permissão para notificações no iOS
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ).then((value) {
          if (value == null || !value) {
            // O usuário negou a permissão
            _showPermissionDeniedDialog();
          }
        });
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Permissão de Notificações Negada"),
          content: const Text(
              "Você negou a permissão para enviar notificações. Você pode ativá-las nas configurações do aplicativo."),
          actions: [
            TextButton(
              child: const Text("Abrir Configurações"),
              onPressed: () {
                _openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _openAppSettings() async {
     Uri iosUri = Uri(scheme: 'app-settings'); // Para iOS
    if (await canLaunchUrl(iosUri)) {
      await launchUrl(iosUri);
    } else {
      // Para Android
      const String androidPackage = 'com.brightlinks.app'; 
       Uri androidUri = Uri.parse('market://details?id=$androidPackage');
      if (await canLaunchUrl(androidUri)) {
        await launchUrl(androidUri);
      }
    }
  }

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
            onTap: () => _showLaunchOptions(Uri.parse('https://exemplo.com/educonnect')),
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
                  "Educonnect (Play Store e App Store)",
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
            onTap: () => _showLaunchOptions(Uri.parse('https://exemplo.com/dailyconnect')),
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
                  "Daily Connect (Play Store e App Store)",
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
            onTap: () => _showLaunchOptions(Uri.parse('https://exemplo.com/toddle')),
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
                  "Toddle (Play Store e App Store)",
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
