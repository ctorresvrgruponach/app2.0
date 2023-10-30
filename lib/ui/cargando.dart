import '../libs/lib.dart';

class Cargando extends StatelessWidget {
  const Cargando({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 20,
      child: Column(
        children: [
          const LogoandSpinner(
            imageAssets: 'assets/images/logonach_azul.png',
            reverse: true,
            arcColor: Colors.blue,
            spinSpeed: Duration(milliseconds: 500),
          ),
          Container(
              margin: const EdgeInsets.only(top: 5),
              child: const Text("Cargando...")),
        ],
      ),
    );
  }
}
