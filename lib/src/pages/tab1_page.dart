import 'package:app_noticias/src/services/news_sercices.dart';
import 'package:app_noticias/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

// AutomaticKeepAliveClientMixin, convertimos a un statelfulwidget para poder manejar este componente, es un controlador de estado , lo utilizamos para que podamos mantener nuestrado ejemplo digamos que estamos scroliando hacia abajo y nos dirigimos a otro lado, en caso que queramos regresar no se pierden los datos donde nos quedamos y nos regresa donde lo dejamos
// esta opcion nos crea un nuevo @overrade que por defecto esta en false osea que una vez la pantalla deja de utilizarse se destruye el estado, debemos espesificarla en true para que no se destruya y el estado se conserve
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // optenemos la informacion de la lista que llenamos en nuestro service, importamos nuestro widnget externo para mandale la info y que la renderice y maneje la informacion
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
        // importando nuestro widget externo de noticias
        body:
            // validacion para cuando tarden en cargar los headlines mostrar una loadind en lo que cargan los componentes
            (headlines.length == 0)
                ? const Center(child: CircularProgressIndicator())
                : ListaNoticias(noticias: headlines));
  }

  // creado para controlar el estado, con la opcion true no se destruye la pantalla en caso que dejemos de utilizarla
  @override
  bool get wantKeepAlive => true;
}
