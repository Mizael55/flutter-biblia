class CorosModel {
  final String titulo;
  final List<String> estrofas;
  final List<String> coro;

  CorosModel({
    required this.titulo,
    required this.estrofas,
    required this.coro,
  });

  // Método para crear una instancia de CorosModel a partir de un JSON
  factory CorosModel.fromJson(Map<String, dynamic> json) {
    return CorosModel(
      titulo: json['titulo'] as String,
      estrofas: List<String>.from(json['estrofas'] as List<dynamic>),
      coro: List<String>.from(json['coro'] as List<dynamic>),
    );
  }

  // Método para convertir una instancia de CorosModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'estrofas': estrofas,
      'coro': coro,
    };
  }

  @override
  String toString() {
    return 'CorosModel(titulo: $titulo, estrofas: $estrofas, coro: $coro)';
  }
}