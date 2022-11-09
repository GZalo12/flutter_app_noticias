// https://newsapi.org/v2/top-headlines?country=MX&apiKey=ce1f4364a63043c2bca07f26677a5652
import 'package:app_noticias/src/models/news_models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

final _URL_NEWS = 'https://newsapi.org/v2/';
final _APIKEY = 'ce1f4364a63043c2bca07f26677a5652';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  // categoria seleccionada
  String _selectedCategory = 'business';

  // categorias de las secciones de la api
  // business entertainment general health science sports technology
  // lista de iconos de las categorias de las opciones que nos manda la api
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vial, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  // maptaque vamos a llenar conla informacion de todas las categorias para no realizar la busqueda muy a menudo
  Map<String, List<Article>> categoryArticles = {};

  // constructor
  NewsService() {
    getTopHeadlines();

    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;

    getArticlesByCategory(valor);
    notifyListeners();
  }

  // get para mostrar los resultados de busqueda de la categoria seleciionada
  List<Article> get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory]!;

  getTopHeadlines() async {
    // para pruebas derespuesta
    // print('Cargandoi headlines');
    // llamado a la api
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=MX';
    // envolvemos en uri.parse por los nuevos cambios desde la libreria de http
    final resp = await http.get(Uri.parse(url));
    final newsResponse = NewsResponse.fromJson(resp.body);

    // cargamos todos los articulos que ya tenemos de respuesta de la api a la lista creada
    headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

// TODO: Revisar de nuevo para mejorar el entendimiento
  // funcion para hacer la peticion a la api sobre la categoria que estamos solicitando
  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      return categoryArticles[category];
    }
    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=MX&category=$category';

    final resp = await http.get(Uri.parse(url));
    final newsResponse = NewsResponse.fromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);
    notifyListeners();
  }
}
