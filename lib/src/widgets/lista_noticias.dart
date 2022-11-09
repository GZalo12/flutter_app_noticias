import 'package:app_noticias/src/models/news_models.dart';
import 'package:app_noticias/src/theme/theme.dart';
import 'package:flutter/material.dart';

class ListaNoticias extends StatelessWidget {
  const ListaNoticias({super.key, required this.noticias});

  final List<Article> noticias;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (context, index) {
        return _Noticia(
          noticia: noticias[index],
          index: index,
        );
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.noticia, required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        _TarjetaTopBar(noticia: noticia, index: index),
        _TarjetaTitulo(noticia),
        _TarjetaImg(noticia),
        _TarjetaBody(noticia),
        const _TarjetaBotones(),
        const SizedBox(),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          RawMaterialButton(
            onPressed: () {},
            //* error de obtencion de color desde el tema seleccionad
            fillColor: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.star_border),
          ),
          const SizedBox(width: 30),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  const _TarjetaBody(this.noticia);
  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:
          Text('${(noticia.description != null) ? noticia.description : ''}'),
    );
  }
}

class _TarjetaImg extends StatelessWidget {
  const _TarjetaImg(this.noticia);
  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100), bottomRight: Radius.circular(100)),
        child: Container(
            padding: const EdgeInsets.all(15),
            child:
                //* en caso de error, de insercion de img,  revisar es el orden de el acomodo de la condicion termaria if
                // indicamos en caso de que no exista una imagen mandar una imagen de respaldo
                (noticia.urlToImage == null)
                    ? const Image(image: AssetImage('assets/no-image.png'))
                    : FadeInImage(
                        placeholder: const AssetImage('assets/giphy.gif'),
                        image: NetworkImage('${noticia.urlToImage}'),
                      )),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  const _TarjetaTitulo(this.noticia);
  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        // modificamos el diseno deltext con un tamano y un grosor
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  const _TarjetaTopBar({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      // separacion entre wodgets
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ',
              style: TextStyle(color: miTema.colorScheme.secondary)),
          Text('${noticia.source.name}.'),
        ],
      ),
    );
  }
}
