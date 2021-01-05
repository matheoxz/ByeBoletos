import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'categoria.dart';
import 'package:ByeBoletos/helpers/DAO.dart';

class Boleto {
  String TITULO, DESCRICAO, ARQUIVO, CODIGO;
  double VALOR;
  int ID, IDCat;
  DateTime DATACHEGADA, DATAVENCIMENTO;
  Categoria CATEGORIA;
  final bd = DAO.instance;
  List<Map<String, dynamic>> cat;
  Future _done;
  bool barreira = false;

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
    getCategoria(map).then((cat) {
      ID = map['ID'];
      TITULO = map['TITULO'];
      VALOR = map['VALOR'];
      DATACHEGADA = DateTime.parse(map['DATACHEGADA']);
      DATAVENCIMENTO = DateTime.parse(map['DATAVENCIMENTO']);
      CODIGO = map['CODIGO'];
      CATEGORIA = Categoria.fromMap(cat[0]);
    });
  }

  Future<List<Map<String, dynamic>>> getCategoria(
      Map<String, dynamic> map) async {
    return await bd.selectCategoriaID(map['CATEGORIA']);
  }

  //Future get initDone => _done;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ID': ID,
      'TITULO': TITULO,
      'VALOR': VALOR,
      'DATACHEGADA': DATACHEGADA.toString(),
      'DATAVENCIMENTO': DATAVENCIMENTO.toString(),
      'CODIGO': CODIGO,
      'CATEGORIA': CATEGORIA.ID
    };
    IDCat = CATEGORIA.ID;
    return map;
  }
}
