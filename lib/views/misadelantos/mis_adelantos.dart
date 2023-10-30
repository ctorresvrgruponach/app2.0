import '../../libs/lib.dart';
import '../../ui/barra_abajo.dart';

class IdAdelantoNotifier extends StateNotifier<String> {
  IdAdelantoNotifier() : super('');

  void updateIdAdelanto(String newValue) {
    state = newValue;
  }
}

class Tamanolist extends StateNotifier<String> {
  Tamanolist() : super('1');

  void updatetamanolist(String newValue) {
    state = newValue;
  }
}

final idAdelantoProvider =
    StateNotifierProvider<IdAdelantoNotifier, String>((ref) {
  return IdAdelantoNotifier();
});

final tamanolistProvider = StateNotifierProvider<Tamanolist, String>((ref) {
  return Tamanolist();
});
final postMisAdelantosProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic dataAdelantos = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointMisAadelantos, postDatas);

  if (dataAdelantos is Map<String, dynamic> &&
      dataAdelantos["success"] != null) {
    if (dataAdelantos["success"]) {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(5.toString());
    } else {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(1.toString());
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataAdelantos;
});

final postMisAdelantosdetalleProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');

  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
    "idAdelanto": ref.watch(idAdelantoProvider),
  };

  final dynamic dataAdelantosdetalle = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointMisAadelantosFiles, postDatas);

  if (dataAdelantosdetalle is Map<String, dynamic> &&
      dataAdelantosdetalle["success"] != null) {
    if (dataAdelantosdetalle["success"]) {
      // Hacer algo si "success" es true.
    } else {
      // Hacer algo si "success" es false.
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataAdelantosdetalle;
});

class MisAdelantos extends ConsumerStatefulWidget {
  const MisAdelantos({super.key});
  @override
  MisAdelantosState createState() => MisAdelantosState();
}

class MisAdelantosState extends ConsumerState<MisAdelantos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 93, 94, 94),
              width: displayWidth(context) *
                  int.parse(ref.watch(tamanolistProvider)),
              height: displayHeight(context) * 0.7,
              child: FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(postMisAdelantosProviders.future),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!['adelantos'] != null) {
                    if (kDebugMode) {
                      print(snapshot.data!);
                    }

                    final adelantos = snapshot.data!['adelantos'];
                    return ListView.builder(
                        itemCount: adelantos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: displayWidth(context) * 0.3,
                            // color: const Color.fromARGB(0, 208, 7, 7),
                            child: Center(
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    index == 0
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                              left: displayWidth(context) * 0.1,
                                              top: displayWidth(context) * 0.06,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.05,
                                                      top: displayWidth(
                                                              context) *
                                                          0.02),
                                                  child: const Text('Ver'),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons
                                                      .remove_red_eye_sharp),
                                                  onPressed: () {
                                                    final notifier = ref.read(
                                                        idAdelantoProvider
                                                            .notifier);
                                                    notifier.updateIdAdelanto(
                                                        snapshot
                                                            .data!['adelantos']
                                                                [index]['id']
                                                            .toString());

                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.9,
                                                        height: displayHeight(
                                                                context) *
                                                            0.6,
                                                        child: AlertDialog(
                                                          title: const Text(
                                                              "Visualizar archivos"),
                                                          content:
                                                              const Text(''),
                                                          actions: <Widget>[
                                                            Column(
                                                              children: [
                                                                const Text(
                                                                    'Selecciona que archivo quieres editar'),
                                                                //  BotoneditGC(
                                                                //    monto:
                                                                //        'monto',
                                                                //    tdescontar:
                                                                //        'tdescontar',
                                                                //    texto:
                                                                //        'COMPROBANTE',
                                                                //    idopselect: snapshot
                                                                //        .data!['adelantos'][
                                                                //            index]
                                                                //            ['id']
                                                                //        .toString(),
                                                                //    ishiden: true,
                                                                //    archivo:
                                                                //        'COMPROBANTE',
                                                                //    nombre:
                                                                //        'COMPROBANTE',
                                                                //    correo:
                                                                //        'COMPROBANTE',
                                                                //  ),
                                                                //  BotoneditGC(
                                                                //    monto:
                                                                //        'monto',
                                                                //    tdescontar:
                                                                //        'tdescontar',
                                                                //    texto: 'INE',
                                                                //    idopselect: snapshot
                                                                //        .data!['adelantos'][
                                                                //            index]
                                                                //            ['id']
                                                                //        .toString(),
                                                                //    ishiden: true,
                                                                //    archivo:
                                                                //        'INE',
                                                                //    nombre: 'INE',
                                                                //    correo: 'INE',
                                                                //  ),
                                                                //  BotoneditGC(
                                                                //    monto:
                                                                //        'monto',
                                                                //    tdescontar:
                                                                //        'tdescontar',
                                                                //    texto: 'CURP',
                                                                //    idopselect: snapshot
                                                                //        .data!['adelantos'][
                                                                //            index]
                                                                //            ['id']
                                                                //        .toString(),
                                                                //    ishiden: true,
                                                                //    archivo:
                                                                //        'CURP',
                                                                //    nombre:
                                                                //        'CURP',
                                                                //    correo:
                                                                //        'CURP',
                                                                //  ),
                                                                const Text(
                                                                    'Selecciona que archivo quieres visualizar'),
                                                                Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: displayWidth(
                                                                            context) *
                                                                        1.9,
                                                                    height:
                                                                        displayHeight(context) *
                                                                            0.5,
                                                                    child: FutureBuilder<
                                                                        Map<String,
                                                                            dynamic>>(
                                                                      future: ref
                                                                          .watch(
                                                                              postMisAdelantosdetalleProviders.future),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          if (kDebugMode) {
                                                                            print(snapshot.data!);
                                                                          }
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data!['adelantos'].length,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return Center(
                                                                                  child: Container(
                                                                                    width: displayWidth(context) * 0.6,
                                                                                    color: const Color.fromARGB(0, 208, 7, 7),
                                                                                    child: Center(
                                                                                      child: SingleChildScrollView(
                                                                                        scrollDirection: Axis.horizontal,
                                                                                        child: SizedBox(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Center(
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsets.only(top: displayWidth(context) * 0.05),
                                                                                                  child: ElevatedButton(
                                                                                                    //onPressed: () => ()),
                                                                                                    style: ElevatedButton.styleFrom(
                                                                                                      backgroundColor: const Color.fromARGB(255, 5, 50, 91),
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
                                                                                                      ), // This is what you need!
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      String url;
                                                                                                      if ((snapshot.data!['adelantos'][index]['mobil'].toString()) == "0") {
                                                                                                        url = """https://nachservice.com.mx/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString()}""";
                                                                                                      } else {
                                                                                                        var protocolo = modo == 'dev' ? protocolodev : protocolossl;
                                                                                                        var apiii = modo == '' ? completeUrldev : baseUrl;
                                                                                                        url = '$protocolo://$apiii/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString().replaceAll('uploads', 'pdf')}';
                                                                                                      }
                                                                                                      SharedPreferencesHelper.setdatos("urlPdfVisor", url);
                                                                                                      Navigator.pushNamed(context, 'pdf');
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      snapshot.data!['adelantos'][index]['nombre_archivo'].toString().toUpperCase(),
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
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          return const Center(
                                                                              child: Cargando());
                                                                        }
                                                                        // By default show a loading spinner.
                                                                        return const Center(
                                                                            child:
                                                                                Cargando());
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
                                                ),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                              left: displayWidth(context) * 0.1,
                                              top: displayWidth(context) * 0.1,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.remove_red_eye_sharp),
                                              onPressed: () {
                                                final notifier = ref.read(
                                                    idAdelantoProvider
                                                        .notifier);
                                                notifier.updateIdAdelanto(
                                                    snapshot.data!['adelantos']
                                                            [index]['id']
                                                        .toString());
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          SizedBox(
                                                    width:
                                                        displayWidth(context) *
                                                            0.9,
                                                    height:
                                                        displayHeight(context) *
                                                            0.5,
                                                    child: AlertDialog(
                                                      title: const Text(
                                                          "Visualizar archivos"),
                                                      content: const Text(
                                                          'Selecciona que archivo quieres visualizar'),
                                                      actions: <Widget>[
                                                        Column(
                                                          children: [
                                                            const Text(
                                                                'Selecciona que archivo quieres editar'),
                                                            //BotoneditGC(
                                                            //  monto: 'monto',
                                                            //  tdescontar:
                                                            //      'tdescontar',
                                                            //  texto:
                                                            //      'COMPROBANTE',
                                                            //  idopselect: snapshot
                                                            //      .data!['adelantos'][index]
                                                            //          ['id']
                                                            //      .toString(),
                                                            //  ishiden: true,
                                                            //  archivo:
                                                            //      'COMPROBANTE',
                                                            //  nombre:
                                                            //      'COMPROBANTE',
                                                            //  correo:
                                                            //      'COMPROBANTE',
                                                            //),
                                                            //BotoneditGC(
                                                            //  monto: 'monto',
                                                            //  tdescontar:
                                                            //      'tdescontar',
                                                            //  texto: 'INE',
                                                            //  idopselect: snapshot
                                                            //      .data!['adelantos'][index]
                                                            //          ['id']
                                                            //      .toString(),
                                                            //  ishiden: true,
                                                            //  archivo: 'INE',
                                                            //  nombre: 'INE',
                                                            //  correo: 'INE',
                                                            //),
                                                            //BotoneditGC(
                                                            //  monto: 'monto',
                                                            //  tdescontar:
                                                            //      'tdescontar',
                                                            //  texto: 'CURP',
                                                            //  idopselect: snapshot
                                                            //      .data!['adelantos'][index]
                                                            //          ['id']
                                                            //      .toString(),
                                                            //  ishiden: true,
                                                            //  archivo: 'CURP',
                                                            //  nombre: 'CURP',
                                                            //  correo: 'CURP',
                                                            //),
                                                            const Text(
                                                                'Selecciona que archivo quieres visualizar'),
                                                            Center(
                                                              child: SizedBox(
                                                                width: displayWidth(
                                                                        context) *
                                                                    1.9,
                                                                height: displayHeight(
                                                                        context) *
                                                                    0.5,
                                                                child: FutureBuilder<
                                                                    Map<String,
                                                                        dynamic>>(
                                                                  future: ref.watch(
                                                                      postMisAdelantosdetalleProviders
                                                                          .future),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasData) {
                                                                      if (kDebugMode) {
                                                                        print(snapshot
                                                                            .data!['adelantos']);
                                                                      }
                                                                      return ListView.builder(
                                                                          itemCount: snapshot.data!['adelantos'].length,
                                                                          itemBuilder: (BuildContext context, int index) {
                                                                            return Center(
                                                                              child: Container(
                                                                                width: displayWidth(context) * 0.6,
                                                                                color: const Color.fromARGB(0, 208, 7, 7),
                                                                                child: Center(
                                                                                  child: SingleChildScrollView(
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    child: SizedBox(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Center(
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.only(top: displayWidth(context) * 0.05),
                                                                                              child: ElevatedButton(
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  backgroundColor: const Color.fromARGB(255, 5, 50, 91),
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
                                                                                                  ), // This is what you need!
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  String url;
                                                                                                  if ((snapshot.data!['adelantos'][index]['mobil'].toString()) == "0") {
                                                                                                    url = """https://nachservice.com.mx/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString()}""";
                                                                                                  } else {
                                                                                                    var protocolo = modo == 'dev' ? protocolodev : protocolossl;
                                                                                                    var apiii = modo == '' ? completeUrldev : baseUrl;
                                                                                                    url = '$protocolo://$apiii/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString().replaceAll('uploads', 'pdf')}';
                                                                                                  }
                                                                                                  SharedPreferencesHelper.setdatos("urlPdfVisor", url);
                                                                                                  Navigator.pushNamed(context, 'pdf');
                                                                                                },
                                                                                                child: Text(
                                                                                                  snapshot.data!['adelantos'][index]['nombre_archivo'].toString().toUpperCase(),
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
                                                                    } else if (snapshot
                                                                        .hasError) {
                                                                      return const Center(
                                                                          child:
                                                                              Text(''));
                                                                    }
                                                                    // By default show a loading spinner.
                                                                    return const Center(
                                                                        child:
                                                                            Cargando());
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
                                            ),
                                          ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: displayWidth(context) * 0.1,
                                        top: displayWidth(context) * 0.1,
                                      ),
                                      child: SizedBox(
                                        width: displayWidth(context) * 0.2,
                                        child: Center(
                                          child: index == 0
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: displayWidth(
                                                                context) *
                                                            0.08,
                                                      ),
                                                      child: const Text(
                                                          'prestamo'),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!['adelantos']
                                                              [index]['id']
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: displayWidth(
                                                                context) *
                                                            0.04,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  snapshot.data!['adelantos']
                                                          [index]['id']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.04,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: displayWidth(context) * 0.1,
                                        top: displayWidth(context) * 0.1,
                                      ),
                                      child: SizedBox(
                                        width: displayWidth(context) * 0.2,
                                        child: Center(
                                          child: index == 0
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: displayWidth(
                                                                context) *
                                                            0.08,
                                                      ),
                                                      child: const Text(
                                                          'Empleado'),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!['adelantos']
                                                              [index]
                                                              ['no_empleado']
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: displayWidth(
                                                                context) *
                                                            0.04,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  snapshot.data!['adelantos']
                                                          [index]['no_empleado']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.04,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: displayWidth(context) * 0.1,
                                        top: displayWidth(context) * 0.1,
                                      ),
                                      child: Center(
                                        child: index == 0
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.08,
                                                    ),
                                                    child: const Text('Nombre'),
                                                  ),
                                                  Text(
                                                    snapshot.data!['adelantos']
                                                            [index]
                                                            ['nombre_completo']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: displayWidth(
                                                              context) *
                                                          0.04,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                snapshot.data!['adelantos']
                                                        [index]
                                                        ['nombre_completo']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.04,
                                                ),
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: displayWidth(context) * 0.1,
                                        top: displayWidth(context) * 0.1,
                                      ),
                                      child: Center(
                                        child: index == 0
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.08,
                                                    ),
                                                    child:
                                                        const Text('Cliente'),
                                                  ),
                                                  Text(
                                                    snapshot.data!['adelantos']
                                                            [index]['clientes']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: displayWidth(
                                                              context) *
                                                          0.04,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                snapshot.data!['adelantos']
                                                        [index]['clientes']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.04,
                                                ),
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: displayWidth(context) * 0.1,
                                        top: displayWidth(context) * 0.1,
                                      ),
                                      child: Center(
                                        child: index == 0
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.08,
                                                    ),
                                                    child:
                                                        const Text('Opereción'),
                                                  ),
                                                  Text(
                                                    snapshot.data!['adelantos']
                                                            [index]
                                                            ['operaciones']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: displayWidth(
                                                              context) *
                                                          0.04,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                snapshot.data!['adelantos']
                                                        [index]['operaciones']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.04,
                                                ),
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: displayWidth(context) * 0.1,
                                        top: displayWidth(context) * 0.1,
                                      ),
                                      child: Center(
                                        child: index == 0
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.08,
                                                    ),
                                                    child:
                                                        const Text('Descuento'),
                                                  ),
                                                  Text(
                                                    double.parse(snapshot.data![
                                                                    'adelantos']
                                                                [index]
                                                            ['descuento'])
                                                        .toStringAsFixed(2)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: displayWidth(
                                                              context) *
                                                          0.04,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                double.parse(snapshot
                                                            .data!['adelantos']
                                                        [index]['descuento'])
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.04,
                                                ),
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: displayWidth(context) * 0.1,
                                        top: displayWidth(context) * 0.1,
                                      ),
                                      child: Center(
                                        child: index == 0
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.08,
                                                    ),
                                                    child: const Text('Total'),
                                                  ),
                                                  Text(
                                                    double.parse(snapshot.data![
                                                                    'adelantos']
                                                                [index]
                                                            ['total_descuento'])
                                                        .toStringAsFixed(2)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: displayWidth(
                                                              context) *
                                                          0.04,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                double.parse(snapshot.data![
                                                            'adelantos'][index]
                                                        ['total_descuento'])
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.04,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(
                          displayWidth(context) * 0.1,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Column(
                            children: [
                              const Spacer(),
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                  shadowColor:
                                      const Color.fromARGB(246, 0, 0, 0),
                                  elevation: 20,
                                  child: SizedBox(
                                    width: 300,
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        'Hubo un error en los datos',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize:
                                                displayWidth(context) * 0.05),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    );
                    // return Text(snapshot.error.toString());
                  } else if (snapshot.hasData &&
                      snapshot.data!['mensaje'] != null) {
                    return SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(
                          displayWidth(context) * 0.1,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Column(
                            children: [
                              const Spacer(),
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                  shadowColor:
                                      const Color.fromARGB(246, 0, 0, 0),
                                  elevation: 20,
                                  child: SizedBox(
                                    width: 300,
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        snapshot.data!['mensaje'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize:
                                                displayWidth(context) * 0.05),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    );
                    // return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return SizedBox(
                    width: displayWidth(context) * 0.5,
                    child: const Center(
                      child: Cargando(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNachBar(context, 0),
    );
  }
}
