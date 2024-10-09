import 'package:centralizador/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Variável para armazenar o termo de pesquisa
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

    // Links para os carrosséis
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
    ];

    final List<Map<String, dynamic>> carouselItems2 = [
      {
        'title': 'Daily Connect',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/daily-connect-child-care/id502426621')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.seacloud.dc'),
        'color': Colors.orange,
      },
      {
        'title': 'Portal do aluno',
        'url': Uri.parse('https://bbsltda149898.rm.cloudtotvs.com.br/FrameHTML/Web/App/Edu/PortalEducacional/login/'),
        'color': Colors.indigo,
      } 
    ];

    final List<Map<String, dynamic>> carouselItems3 = [
      {
        'title': 'Daily Connect',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/daily-connect-child-care/id502426621')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.seacloud.dc'),
        'color': Colors.orange,
      },
      {
        'title': 'Toddle',
        'url': Platform.isIOS
            ? Uri.parse('https://apps.apple.com/br/app/toddle-educator/id1529065681')
            : Uri.parse('https://play.google.com/store/apps/details?id=com.toddle.teacher'),
        'color': Colors.red,
      },
    ];

    // Função para filtrar itens com base no termo de pesquisa
    List<Map<String, dynamic>> filterItems(List<Map<String, dynamic>> items) {
      if (searchTerm.isEmpty) {
        return items;
      }
      return items.where((item) => item['title'].toLowerCase().contains(searchTerm.toLowerCase())).toList();
    }

    // Função para lidar com a pesquisa
    void search(String query) {
      setState(() {
        searchTerm = query.isNotEmpty ? query : '';
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bright Links"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  onSearch: search, // Chama a função de pesquisa diretamente
                  items: [...carouselItems1, ...carouselItems2, ...carouselItems3],
                  launchUrl: _launchURL, // Passa a função para abrir o URL
                ),
              );
            },
          ),
        ],
      ),
      body: searchTerm.isNotEmpty
          ? Center(
              child: _buildSingleResult(
                [...carouselItems1, ...carouselItems2, ...carouselItems3]
                  .where((item) => item['title'].toLowerCase().contains(searchTerm.toLowerCase()))
                  .toSet() // Remove duplicatas
                  .toList(),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.max, // Garante que a coluna ocupe todo o espaço
              children: [
                Text('Status: ${appState.status}'), // Exibe o status atual

                // Primeiro carrossel
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(height: 200),
                    items: filterItems(carouselItems1).map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () => _showLaunchOptions(item['url']),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                ),

                const SizedBox(height: 20), // Espaço entre os carrosséis

                // Segundo carrossel
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(height: 200),
                    items: filterItems(carouselItems2).map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () => _showLaunchOptions(item['url']),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                ),

                const SizedBox(height: 20), // Espaço entre os carrosséis

                // Terceiro carrossel
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(height: 200),
                    items: filterItems(carouselItems3).map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () => _showLaunchOptions(item['url']),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                ),
              ],
            ),
    );
  }

  // Widget para exibir o resultado único da pesquisa
  Widget _buildSingleResult(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return const Text("Nenhum resultado encontrado.");
    }

    final item = items.first; // Exibe apenas o primeiro resultado
    return Card(
      color: item['color'],
      child: ListTile(
        title: Text(
          item['title'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => _launchURL(item['url']),
      ),
    );
  }
}

// Classe personalizada para o delegate de pesquisa
class CustomSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;
  final List<Map<String, dynamic>> items;
  final Function(Uri) launchUrl;

  CustomSearchDelegate({
    required this.onSearch,
    required this.items,
    required this.launchUrl,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = items.where((item) => item['title'].toLowerCase().contains(query.toLowerCase())).toList();

    return ListView(
      children: results.map((item) {
        return ListTile(
          title: Text(item['title']),
          onTap: () => launchUrl(item['url']),
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = items.where((item) => item['title'].toLowerCase().contains(query.toLowerCase())).toList();

    return ListView(
      children: suggestions.map((item) {
        return ListTile(
          title: Text(item['title']),
          onTap: () => launchUrl(item['url']),
        );
      }).toList(),
    );
  }
}
