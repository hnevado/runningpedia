class WineTerm {
  final int id;
  final String termino;
  final String definicionCorta;
  final String definicionLarga;
  final String ejemplo;
  final List<String> sinonimos;
  final String imagenUrl;
  final String categoria;

  WineTerm({
    required this.id,
    required this.termino,
    required this.definicionCorta,
    required this.definicionLarga,
    required this.ejemplo,
    required this.sinonimos,
    required this.imagenUrl,
    required this.categoria,
  });

  factory WineTerm.fromJson(Map<String, dynamic> json) {
    return WineTerm(
      id: json['id'],
      termino: json['termino'],
      definicionCorta: json['definicion_corta'],
      definicionLarga: json['definicion_larga'],
      ejemplo: json['ejemplo'],
      sinonimos: List<String>.from(json['sinonimos']),
      imagenUrl: json['imagen_url'],
      categoria: json['categoria'],
    );
  }
}