import '../libs/lib.dart';

class Botoneditar extends ConsumerStatefulWidget {
  final String texto;
  final String? indiceadelanto;

  const Botoneditar({
    Key? key,
    required this.texto,
    required this.indiceadelanto,
  }) : super(key: key);

  @override
  BotoneditarState createState() => BotoneditarState();
}

class BotoneditarState extends ConsumerState<Botoneditar> {
  @override
  void initState() {
    super.initState();
    setState(() {
      setState(() {
        filterColor = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(filterColor ? 255 : 50, 5, 50, 91),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ),
      ),
      onPressed: () {
        final notifier = ref.read(idAdelantoProvider.notifier);
        notifier.updateIdAdelanto(widget.indiceadelanto as String);

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            width: displayWidth(context) * 0.9,
            height: displayHeight(context) * 0.6,
            child: AlertDialog(
              title: const Text("Visualizar archivos"),
              content: const Text(''),
              actions: <Widget>[
                Column(
                  children: [
                    const Text('Selecciona que archivo quieres editar'),
                    const Botonfile(texto: 'INE'),
                    const Botonfile(texto: 'Comprobante'),
                    const Botonfile(texto: 'CURP'),
                    const Text('Selecciona que archivo quieres visualizar'),
                    Center(
                      child: SizedBox(
                        width: displayWidth(context) * 1.9,
                        height: displayHeight(context) * 0.5,
                        child: FutureBuilder<Map<String, dynamic>>(
                          future: ref
                              .watch(postMisAdelantosdetalleProviders.future),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (kDebugMode) {
                                print(snapshot.data!['adelantos']);
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data!['adelantos'].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Center(
                                      child: Container(
                                        width: displayWidth(context) * 0.6,
                                        color:
                                            const Color.fromARGB(0, 208, 7, 7),
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: SizedBox(
                                              child: Row(
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: displayWidth(
                                                                  context) *
                                                              0.05),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  5, 50, 91),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    displayWidth(
                                                                            context) *
                                                                        0.02),
                                                          ), // This is what you need!
                                                        ),
                                                        onPressed: () {
                                                          String url;
                                                          if ((snapshot.data![
                                                                      'adelantos']
                                                                      [index]
                                                                      ['mobil']
                                                                  .toString()) ==
                                                              "0") {
                                                            url =
                                                                """https://nachservice.com.mx/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString()}""";
                                                          } else {
                                                            var protocolo = modo ==
                                                                    'dev'
                                                                ? protocolodev
                                                                : protocolossl;
                                                            var apiii = modo ==
                                                                    'dev'
                                                                ? completeUrldev
                                                                : baseUrl;
                                                            url =
                                                                '$protocolo://$apiii/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString().replaceAll('uploads', 'pdf')}';
                                                          }
                                                          SharedPreferencesHelper
                                                              .setdatos(
                                                                  "urlPdfVisor",
                                                                  url);
                                                          Navigator.pushNamed(
                                                              context, 'pdf');
                                                        },
                                                        child: Text(
                                                          snapshot.data![
                                                                  'adelantos']
                                                                  [index][
                                                                  'nombre_archivo']
                                                              .toString()
                                                              .toUpperCase(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return const Center(child: Text(''));
                            }
                            // By default show a loading spinner.
                            return const Center(child: Cargando());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      child: Text(' ${widget.texto}'),
    );
  }
}