import 'package:app_noticias/src/pages/tab1_page.dart';
import 'package:app_noticias/src/pages/tab2_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // para poder trabaja rcon la informacion conprovider necesitamos envolver el widget o la pagina con mayor gerarquia para que desde ahi se distribuya la informacion en este caso fue en la cima de nuestra page
    return ChangeNotifierProvider(
      // mediante el create optenemos la instancia global de informacion de nuestro provider que manejaremos la infor de navegacion model para el cambio de botones y paginas
      create: (context) => _NavegacionModel(),
      child: const Scaffold(
        // paginas en widgets externo
        body: _Paginas(),
        // menu de navegacion
        bottomNavigationBar: _NavegacionButton(),
      ),
    );
  }
}

//  barra de botones de navegacion
class _NavegacionButton extends StatelessWidget {
  const _NavegacionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // buscamos y optenemos la informacion global de nuestro modelo
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      // seleccion de las opciones del menu de botones, soloesta escuchando el get
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) {
        // disparamos set cuando  modficamos el valor
        navegacionModel.paginaActual = value;
      },
      // cambio de color cuando se da click algun icono, solo reacciona cuando se seleeciona
      selectedItemColor: navegacionModel.color,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    // navegacion entre pantallas
    return PageView(
      // control de la navegacion mediante la precion de los botones de nuestra barra de navegacion
      controller: navegacionModel.pageController,
      // cuando llegue al final de la pantalla y intente navegacion y ya no exista hace efecto de rebote
      // physics: const BouncingScrollPhysics(),
      // bloquemos la navegacion por scroll y implementaremos la nave gacion por botones de seleccion
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        // pantallas a llamar
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

// Singlenton
// creamos un widget independiente para notificar en caso de que exista  algun cambio para que se cambios en caso de haberlos
// classe donde ndicamos a nuestro widget que si existe algun cambio se redibuje en este caso cuando se preciona alguno de nuestros botones de menu
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();
  Color _color = Colors.green;

  // get de solo lectura, cuando se esta escuchando
  int get paginaActual => _paginaActual;

  // set es de escritura, pero tambien cuando existe alguna modificiacion se dispara
  set paginaActual(int valor) {
    _paginaActual = valor;

    // modificacion del valor mediante una animacion para realizar el cambio de pagina mediante la precion opcional de los botones de navegaciones del menu
    _pageController.animateToPage(
      valor,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }

  // get, escuchador de controlador de pagina
  PageController get pageController => _pageController;
  Color get color => _color;
}
