import '../libs/lib.dart';

const int minValue = 1;
const int maxValue = 100;

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
      counter: SizedBox.shrink(),
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

class DecoracionPersonal {
  static const Color _fillColor = Color.fromARGB(128, 190, 191, 194);
  static const Color _focusedBorderColor = Color.fromARGB(255, 190, 191, 194);
  static const Color _borderColor = Color.fromARGB(128, 190, 191, 194);
  static const Color _labelColor = Color.fromARGB(255, 5, 50, 91);

  static const double _borderWidthFocused = 2.0;
  static const double _borderWidth = 5.0;
  static const double _borderRadius = 5.0;

  static InputDecoration get decoracionPersonal {
    return const InputDecoration(
      filled: true,
      fillColor: _fillColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        borderSide: BorderSide(
          width: _borderWidthFocused,
          color: _focusedBorderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: _borderWidth,
          color: _borderColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      ),
      labelStyle: TextStyle(
        color: _labelColor,
      ),
    );
  }

  static List<TextInputFormatter> get inputFormatters {
    return [
      FilteringTextInputFormatter.allow(
        RegExp(
          r'[1-9]*[.]?[0-9]',
        ),
      ),
    ];
  }

  static List<TextInputFormatter> get inputFormatterspor {
    return [
      FilteringTextInputFormatter.allow(
        RegExp(
          r'[1-9]*[.]?[0-9]',
        ),
      ),
      NumericalRangeFormatter(minValue, maxValue),
    ];
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final int minValue;
  final int maxValue;

  NumericalRangeFormatter(this.minValue, this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final parsed = int.tryParse(newValue.text);

    if (parsed == null) {
      // Return the old value if the input is not a valid integer
      return oldValue;
    }

    if (parsed < minValue) {
      // Return the old value if the input is less than the minimum value
      return oldValue;
    }

    if (parsed > maxValue) {
      // Return the old value if the input is greater than the maximum value
      return oldValue;
    }

    // Allow the input if it satisfies the conditions
    return newValue;
  }
}

class MyButtonStyle {
  static ButtonStyle customElevatedButtonStyle(
      BuildContext context, String texto) {
    return ElevatedButton.styleFrom(
      fixedSize: Size(
        MediaQuery.of(context).size.width * 0.4,
        MediaQuery.of(context).size.width * 0.1,
      ),
      backgroundColor:
          Color.fromARGB(someMap[texto] != texto ? 255 : 50, 5, 50, 91),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
      ),
    );
  }

  static double displayWidth(BuildContext context) {
    // Add your logic to get the display width
    return MediaQuery.of(context).size.width;
  }
}
