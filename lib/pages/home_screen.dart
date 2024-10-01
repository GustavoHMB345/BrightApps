import 'package:centralizador/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';

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

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ).then((value) {
          if (value == null || !value) {
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
      const String androidPackage = 'com.brightlinks.app'; 
      Uri androidUri = Uri.parse('market://details?id=$androidPackage');
      if (await canLaunchUrl(androidUri)) {
        await launchUrl(androidUri);
      }
    }
  }

  void _launchURL(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
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
          title: const Text("Abrir Link"),
          content: const Text("Deseja abrir o link no navegador ou no aplicativo?"),
          actions: [
            TextButton(
              child: const Text("Navegador"),
              onPressed: () {
                _launchURL(uri);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Aplicativo"),
              onPressed: () {
                _launchURL(uri);
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
    final appState = Provider.of<AppState>(context); // Acessa o estado do aplicativo

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bright Links"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Status: ${appState.status}'), // Exibe o status atual
          InkWell(
            onTap: () => _showLaunchOptions(
              Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/'),
            ),
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
            onTap: () => _showLaunchOptions(
              Platform.isIOS 
                  ? Uri.parse('https://apps.apple.com/br/app/meu-educonnect/id1255287155') 
                  : Uri.parse('https://play.google.com/store/apps/details?id=com.educonnect.totvs&hl=pt_BR&pli=1'),
            ),
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
                  "Educonnect",
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
            onTap: () => _showLaunchOptions(
              Platform.isIOS 
                  ? Uri.parse('https://apps.apple.com/br/app/daily-connect-child-care/id502426621') 
                  : Uri.parse('https://play.google.com/store/apps/details?id=com.seacloud.dc'),
            ),
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
                  "Daily Connect",
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
            onTap: () => _showLaunchOptions(
              Platform.isIOS 
                  ? Uri.parse('https://apps.apple.com/br/app/toddle-educator/id1529065681') 
                  : Uri.parse('https://play.google.com/store/apps/details?id=com.toddle.teacher'),
            ),
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
                  "Toddle",
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