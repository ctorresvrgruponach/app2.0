import '../libs/lib.dart';

class Cargando extends StatelessWidget {
  const Cargando({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        shadowColor: const Color.fromARGB(246, 0, 0, 0),
        elevation: 20,
        color: const Color.fromARGB(125, 255, 255, 255),
        child: SizedBox(
          width: displayWidth(context) * 0.5,
          height: displayHeight(context) * 0.4,
          child: Center(
            widthFactor: 20,
            child: Column(
              children: [
                const LogoandSpinner(
                  imageAssets: 'assets/images/logonach_azul.png',
                  reverse: true,
                  arcColor: Color.fromARGB(255, 53, 86, 117),
                  spinSpeed: Duration(milliseconds: 500),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text("Cargando...")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
