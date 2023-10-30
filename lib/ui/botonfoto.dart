import '../config/vistas.dart';

class BotonGC extends PedirAdelantoScreen {
  const BotonGC({
    super.key,
    required this.monto,
    required this.tdescontar,
    required this.texto,
    required this.ishiden,
    required this.idopselect,
    this.archivo,
    this.nombre,
    this.correo,
  });

  final String monto;
  final String tdescontar;
  final String texto;
  final String? nombre;
  final String? correo;
  final String? archivo;
  final bool ishiden;

  final String idopselect;
}
