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

  // Método para exibir o diálogo
void _launchURLDialog(Uri uri) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Abrir Link"),
        content: const Text("Deseja abrir o link no app ou no navegador externo?"),
        actions: <Widget>[
          TextButton(
            child: const Text("Navegador Externo"),
            onPressed: () async {
              Navigator.of(context).pop();
              _openURL(uri, LaunchMode.externalApplication); // Chama o método renomeado
            },
          ),
          TextButton(
            child: const Text("App"),
            onPressed: () async {
              Navigator.of(context).pop();
              _openURL(uri, LaunchMode.inAppWebView); // Chama o método renomeado
            },
          ),
        ],
      );
    },
  );
}

// Método para abrir o link com o modo especificado
Future<void> _openURL(Uri uri, LaunchMode mode) async {
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
    }
  } catch (e) {
    print(e.toString());
  }
}

void _confirmLogout() {
  showDialog(context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmação de de Logout"),
      content: const Text("Você tem certeza que deseja sair?"),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancelar"),
          onPressed:() {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child:const Text("Sair") ,
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/');
          },
          ),
      ],
    );
  },
  );
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
        'title': 'Educonnect',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/meu-educonnect/id1255287155')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.educonnect.totvs&hl=pt_BR&pli=1'),
        'color': Colors.blue,
      },
      {
        'title': 'Portal do aluno',
        'url': Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/'),
        'color': Colors.indigo,
      },
    ];

    final List<Map<String, dynamic>> carouselItems4 = [
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
      {
        'title': 'Educonnect',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/meu-educonnect/id1255287155')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.educonnect.totvs&hl=pt_BR&pli=1'),
        'color': Colors.blue,
      },
    ];

    List<Map<String, dynamic>> filterItems(List<Map<String, dynamic>> items) {
      if (searchTerm.isEmpty) {
        return items;
      }
      return items.where((item) =>
          item['title'].toLowerCase().contains(searchTerm.toLowerCase())).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bright Links"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
             ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configurações'),
          onTap: () {
            Navigator.pop(context);
            // Ação de navegação ou lógica aqui
          },
            ),
             ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Sair'),
          onTap: () {
            Navigator.pop(context);
            _confirmLogout();
            },
            ),
            // Lógica de logout ou navegação
          ],
        ),
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'), 
                fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a tela
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: SizedBox(
                    width: 600,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Buscar...",
                        hintStyle: const TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

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
                          onTap: () => _launchURLDialog(item['url']),
                          child: Container(
                            width: 700, // Modifique o tamanho da largura dos cards
                            height: 150, // Modifique a altura dos cards
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: item['color'],
                              borderRadius: BorderRadius.circular(20),
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

                const SizedBox(height: 10),

                // Nome acima do carrossel 2
                const Text(
                  'Fund 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Carrossel 2
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                  ),
                  items: filterItems(carouselItems2).map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () => _launchURLDialog(item['url']),
                          child: Container(
                            width: 700,
                            height: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: item['color'],
                              borderRadius: BorderRadius.circular(20),
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

                const SizedBox(height: 10),

                // Nome acima do carrossel 3
                const Text(
                  'Fund 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Carrossel 3
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                  ),
                  items: filterItems(carouselItems3).map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () => _launchURLDialog(item['url']),
                          child: Container(
                            width: 700,
                            height: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: item['color'],
                              borderRadius: BorderRadius.circular(20),
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

                const SizedBox(height: 10),

                // Nome acima do carrossel 4
                const Text('Ensino médio',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Carrossel 4
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                  ),
                  items: filterItems(carouselItems4).map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () => _launchURLDialog(item['url']),
                          child: Container(
                            width: 700,
                            height: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: item['color'],
                              borderRadius: BorderRadius.circular(20),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}