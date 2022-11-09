import 'package:app_noticias/src/models/category_model.dart';
import 'package:app_noticias/src/services/news_sercices.dart';
import 'package:app_noticias/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const _ListaCategorias(),
          // reutilizamos nuestro widget del tab1 para utilizarlo en mostrar las noticias por las categorias como  de botones de seleccion
          Expanded(
            child: ListaNoticias(
                noticias: newsService.getArticulosCategoriaSeleccionada),
          ),
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // obtenemos el listado de categorias
    final categorias = Provider.of<NewsService>(context).categories;
    // presentamosnuestras opciones en una lista de vistas
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        // animacion para simular un rebote
        physics: const BouncingScrollPhysics(),
        // mostrarlo en desplazamiento horizontal
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final cName = categorias[index].name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categorias[index]),
                const SizedBox(height: 5),
                // capitalizamos la primer letra, para eso utilizamos su posicion y nos ayuda la funcion toUpperCase, de igual forma concatenamos lo que le continua de texto, para que aparesca normal, y le indicamos mediante subString que  comience desde la posicion 1 ya que la posicion 0 esta capitalizada
                Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        print(categoria.name);
        // obtenemos la informacion del provider, y mediante el listen el false indicamos que este elemento no se tiene que redibujar
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categoria.icon,
            color:
                //instancia para cambiar de color cuando se seleccione algunas de las opciones
                (newsServices.selectedCategory == categoria.name)
                    ? Colors.red
                    : Colors.black54
            //,
            ),
      ),
    );
  }
}
