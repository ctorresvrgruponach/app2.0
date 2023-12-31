import '../../api/apilogin.dart';
import '../../libs/lib.dart';

class OtraPantalla extends HookConsumerWidget {
  const OtraPantalla({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final resp = ref.watch(postDataProviders);
    final postDataProviders1 = ref.watch(postDataProviders);

    // final arguments = ModalRoute.of(context)!.settings.arguments;
    //final receivedData = arguments as String; // Adjust the type as needed

    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navega a la otra pantalla utilizando Navigator.pushNamed
                Navigator.pushNamed(context, '/');
              },
              child: const Column(
                children: [
                  // Text('Received Data: $receivedData'),
                  Text('Ir a Otra Pantalla'),
                ],
              ),
            ),
          ),
          Center(
            child: postDataProviders1.when(
              data: (data) {
                return Text('Respuesta: final nombre = ${data['token']}');
              },
              loading: () {
                return const CircularProgressIndicator();
              },
              error: (error, stackTrace) {
                return Text('Error: $error');
              },
            ),
          ),
        ],
      ),
    );
  }
}
