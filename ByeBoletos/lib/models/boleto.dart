import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'categoria.dart';

class Boleto {
  String TITULO, DESCRICAO, ARQUIVO, CODIGO;
  double VALOR;
  int ID;
  DateTime DATACHEGADA, DATAVENCIMENTO;
  Categoria CATEGORIA;

  Boleto(
      {@required this.TITULO,
      @required this.VALOR,
      @required this.DATACHEGADA,
      @required this.DATAVENCIMENTO,
      @required this.CATEGORIA,
      this.ARQUIVO,
      this.DESCRICAO,
      this.CODIGO});

  Boleto.fromMap(Map<String, dynamic> map) {
    ID = map['ID'];
    TITULO = map['TITULO'];
    VALOR = map['VALOR'];
    DATACHEGADA = map['DATACHEGADA'];
    DATAVENCIMENTO = map['DATAVENCIMENTO'];
    CODIGO = map['CODIGO'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ID': ID,
      'TITULO': TITULO,
      'VALOR': VALOR,
      'DATACHEGADA': DATACHEGADA,
      'DATAVENCIMENTO': DATAVENCIMENTO,
      'CODIGO': CODIGO
    };
    return map;
  }
}
