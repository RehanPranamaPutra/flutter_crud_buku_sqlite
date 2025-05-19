class ModelBuku {
  final int? id;
  final String judulBuku;
  final String kategori;

  ModelBuku({this.id, required this.judulBuku, required this.kategori});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judulBuku': judulBuku,
      'kategori': kategori,
    };
  }

  factory ModelBuku.fromMap(Map<String, dynamic> map) {
    return ModelBuku(
      id: map['id'],
      judulBuku: map['judulBuku'],
      kategori: map['kategori'],
    );
  }
}