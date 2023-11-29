import '../libs/lib.dart';
import '../views/cajadeahorro/valorescaja.dart';
import 'decoracioninput.dart';

class Persona {
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String porcentaje;
  Persona(
      this.nombre, this.apellidoPaterno, this.apellidoMaterno, this.porcentaje);

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'porcentaje': porcentaje
    };
  }
}

class PersonasListWidget extends StatefulWidget {
  const PersonasListWidget({super.key});

  @override
  PersonasListWidgetState createState() => PersonasListWidgetState();
}

class PersonasListWidgetState extends State<PersonasListWidget> {
  List<Persona> personasList = [Persona('', '', '', '')];

  void agregarPersona() {
    setState(() {
      personasList.add(Persona('', '', '', ''));
    });
  }

  void eliminarPersona() {
    setState(() {
      if (personasList.length > 1) {
        personasList.removeLast();
      }
    });
  }

  String convertirAJSON() {
    // Check if all percentages are provided and sum to 100
    if (validatePorcentajes()) {
      List<Map<String, dynamic>> personasJsonList =
          personasList.map((persona) => persona.toJson()).toList();
      return jsonEncode(personasJsonList);
    } else {
      // Show an error message or handle validation failure
      if (kDebugMode) {
        print('Porcentajes deben sumar 100% y no pueden estar vacíos');
      }
      return ''; // or return an error message
    }
  }

  bool validatePorcentajes() {
    // Check if all percentages are provided
    if (personasList.any((persona) =>
        persona.nombre.trim().length < 2 &&
        persona.apellidoPaterno.trim().length < 2 &&
        persona.apellidoMaterno.trim().length < 2)) {
      return false;
    }

    // Check if the sum of percentages is 100
    int sumPorcentajes = personasList.fold<int>(
        0,
        (previousValue, persona) =>
            previousValue + int.parse(persona.porcentaje));

    return sumPorcentajes == 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(personasList.length, (index) {
                  return SizedBox(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textosFijo10(context, 'Beneficiario ${index + 1}'),
                        textosFijo10(context, 'Nombres:'),
                        // Agregar numeración
                        TextField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 5, 50, 91),
                          ),
                          decoration: DecoracionPersonal.decoracionPersonal,
                          controller: TextEditingController(
                              text: personasList[index].nombre),
                          onChanged: (value) {
                            personasList[index].nombre = value;
                          },
                        ),
                        textosFijo10(context, 'Apellido Paterno:'),
                        TextField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 5, 50, 91),
                          ),
                          decoration: DecoracionPersonal.decoracionPersonal,
                          controller: TextEditingController(
                              text: personasList[index].apellidoPaterno),
                          onChanged: (value) {
                            personasList[index].apellidoPaterno = value;
                          },
                        ),
                        textosFijo10(context, 'Apellido Materno:'),
                        TextField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 5, 50, 91),
                          ),
                          decoration: DecoracionPersonal.decoracionPersonal,
                          controller: TextEditingController(
                              text: personasList[index].apellidoMaterno),
                          onChanged: (value) {
                            personasList[index].apellidoMaterno = value;
                          },
                        ),
                        textosFijo10(context, 'Porcentaje:'),
                        TextField(
                          inputFormatters:
                              DecoracionPersonal.inputFormatterspor,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 5, 50, 91),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: DecoracionPersonal.decoracionPersonal,
                          controller: TextEditingController(
                              text: personasList[index].porcentaje.toString()),
                          onChanged: (value) {
                            personasList[index].porcentaje = value;
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: MyButtonStyle.customElevatedButtonStyle(
                      context, 'Agregar Beneficiario'),
                  onPressed: agregarPersona,
                  child: const Text('Agregar Beneficiario'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: MyButtonStyle.customElevatedButtonStyle(
                      context, 'Eliminar Beneficiario'),
                  onPressed: eliminarPersona,
                  child: const Text('Eliminar Beneficiario'),
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          style:
              MyButtonStyle.customElevatedButtonStyle(context, 'Aceptar caja'),
          onPressed: () {
            // Llamar a la función de conversión a JSON
            String jsonResult = convertirAJSON();
            if (kDebugMode) {
              print(jsonResult);
            }
            // Puedes usar jsonResult según tus necesidades (enviar a una API, guardar en un archivo, etc.)
          },
          child: const Text('Aceptar caja'),
        ),
      ],
    );
  }
}

// Agrega la función textosFijo10 según sea necesario
