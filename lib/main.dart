import 'package:app_noticias/src/pages/tabs_page.dart';
import 'package:app_noticias/src/services/news_sercices.dart';
import 'package:app_noticias/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // importando nuestro servicio para la info de nuestro modelo json
        ChangeNotifierProvider(create: (context) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const TabsPage(),
        theme: miTema,
      ),
    );
  }
}
