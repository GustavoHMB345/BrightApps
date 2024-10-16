import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String searchTerm = '';

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
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
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
    Uri iosUri = Uri(scheme: 'app-settings');
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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> carouselItems1 = [
      {
        'title': 'Portal do aluno',
        'url': Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/'),
        'color': Colors.indigo,
      },
      {
        'title': 'Educonnect',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/meu-educonnect/id1255287155')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.educonnect.totvs&hl=pt_BR&pli=1'),
        'color': Colors.blue,
      },
      {
        'title': 'Daily Connect',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/daily-connect-child-care/id502426621')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.seacloud.dc'),
        'color': Colors.orange,
      },
    ];

    final List<Map<String, dynamic>> carouselItems2 = [
      {
        'title': 'Portal do aluno',
        'url': Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/'),
        'color': Colors.indigo,
      },
      {
        'title': 'Educonnect',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/meu-educonnect/id1255287155')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.educonnect.totvs&hl=pt_BR&pli=1'),
        'color': Colors.blue,
      },  
    ];

    final List<Map<String, dynamic>> carouselItems3 = [
      {
        'title': 'Toddle',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/toddle-educator/id1529065681')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.toddle.teacher'),
        'color': Colors.red,
      },
      { 
        'title': 'Portal do aluno',
        'url': Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/'),
        'color': Colors.indigo,
      },

    ];final List<Map<String, dynamic>> carouselItems4 = [
      {
        'title': 'Toddle',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/toddle-educator/id1529065681')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.toddle.teacher'),
        'color': Colors.red,
      },
      {
        'title': 'Portal do aluno',
        'url': Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/'),
        'color': Colors.indigo,
      },
    ];

    List<Map<String, dynamic>> filterItems(List<Map<String, dynamic>> items) {
      if (searchTerm.isEmpty) {
        return items;
      }
      return items
          .where((item) =>
              item['title'].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bright Links"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo de busca
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Buscar...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Nome acima do carrossel 1
            const Text(
              'Infantil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Carrossel 1
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: 0.6, // Mostra uma fração do carrossel
                enlargeCenterPage: true, // Destaca o item central
              ),
              items: filterItems(carouselItems1).map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () => _launchURL(item['url']),
                      child: Container(
                        width: 700, // Modifique o tamanho da largura dos cards
                        height: 150, // Modifique a altura dos cards
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Nome acima do carrossel 2
            const Text(
              'Fundamental 1',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Carrossel 2
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: 0.6, // Mostra uma fração do carrossel
                enlargeCenterPage: true, // Destaca o item central
              ),
              items: filterItems(carouselItems2).map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () => _launchURL(item['url']),
                      child: Container(
                        width: 700,
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Nome acima do carrossel 3
            const Text(
              'Fundamental 2',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Carrossel 3
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: 0.6, // Mostra uma fração do carrossel
                enlargeCenterPage: true, // Destaca o item central
              ),
              items: filterItems(carouselItems3).map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () => _launchURL(item['url']),
                      child: Container(
                        width: 700,
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            
             // Nome acima do carrossel 2
            const Text(
              'Ensino médio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Carrossel 4
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: 0.6, // Mostra uma fração do carrossel
                enlargeCenterPage: true, // Destaca o item central
              ),
              items: filterItems(carouselItems4).map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () => _launchURL(item['url']),
                      child: Container(
                        width: 700,
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
 // Espaço final após o último carrossel
          ],
        ),
      ),
    );
  }
}
