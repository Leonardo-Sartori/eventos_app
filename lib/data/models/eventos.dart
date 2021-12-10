class Eventos {
  int? id;
  String? nome;
  String? local;
  DateTime? dataEvento;
  double? valorEntrada;
  String? foto;
  String? observacao;
  
  Eventos({this.id, this.nome, this.local, this.dataEvento, this.valorEntrada, this.foto, this.observacao});
  
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["nome"] = this.nome;
    data["dataEvento"] = this.dataEvento;
    data["valorEntrada"] = this.valorEntrada;
    data["foto"] = this.foto;
    data["observacao"] = this.observacao;
    return data;
  }
  
  Eventos.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nome = map["nome"];
    dataEvento = map["dataEvento"];
    valorEntrada = map["valorEntrada"];
    foto = map["foto"];
    observacao = map["observacao"];
  }


  /*
    int
    String
    DateTime
    double
    bool
    Blob
  */
}