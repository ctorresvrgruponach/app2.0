import '../libs/lib.dart';

class NavegadorDeRuta {
  final BuildContext context;
  final List<dynamic> argumentos;

  NavegadorDeRuta(this.context, this.argumentos);

  Future<void> algunlugar(lugar) async {
    Navigator.pushNamedAndRemoveUntil(context, lugar, (route) => false,
        arguments: argumentos);
  }

  Future<void> navigateToReviewPage(Uint8List? signature, lugar) async {
    Navigator.of(context).pushNamed(lugar);
  }
}
