import '../libs/lib.dart';

class CustomInputDecoration {
  static InputDecoration getDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Color.fromARGB(0, 229, 4, 4),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(
          width: 2, //<-- SEE HERE
          color: Color.fromARGB(0, 254, 0, 0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 5, //<-- SEE HERE
          color: Color.fromARGB(0, 254, 0, 0),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 5, //<-- SEE HERE
          color: Color.fromARGB(0, 190, 191, 194),
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 5, 49, 91),
      ),
    );
  }
}

class CustomTitulo {
  SizedBox textot1(context, texto) {
    return SizedBox(
      width: displayWidth(context) * 0.4,
      child: Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.03),
        child: Text(
          '$texto',
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
