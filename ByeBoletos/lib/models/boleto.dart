import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Boleto {
  String titulo, descricao, cod, pathArquivo;
  double valor;
  DateTime dataChegada, dataVencimento;

  Boleto(
      {@required this.cod,
      @required this.titulo,
      @required this.valor,
      @required this.dataChegada,
      @required this.dataVencimento,
      this.pathArquivo,
      this.descricao});

  Boleto.fromMap(Map<String, dynamic> map) {
    cod = map['cod'];
    titulo = map['titulo'];
    valor = map['valor'];
    dataChegada = map['dataChegada'];
    dataVencimento = map['dataVencimento'];
    pathArquivo = map['pathArquivo'];
    descricao = map['descricao'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'cod': cod,
      'titulo': titulo,
      'valor': valor,
      'dataChegada': dataChegada,
      'dataVencimento': dataVencimento,
      'pathArquivo': pathArquivo,
      'descricao': descricao
    };
    return map;
  }
}
