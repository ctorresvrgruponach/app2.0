import '../config/vistas.dart';

class CenteredLineContainer extends StatelessWidget {
  const CenteredLineContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 53, 86, 117),
      child: Center(
        child: Column(
          children: [
            CustomPaint(
              size: const Size(50, 50), // Tamaño del área de dibujo
              painter: LinePainter(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Firmar por arriba de la linea',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Color de la línea (blanco en este caso)
      ..strokeWidth = 2.0; // Grosor de la línea

    final center = size.center(Offset.zero);
    canvas.drawLine(center.translate(-90, 0), center.translate(90, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
