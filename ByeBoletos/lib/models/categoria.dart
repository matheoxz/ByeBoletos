import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Categoria {
  String NOME, ICONE, CORHEX;
  int ID;
  Color COR;

  Categoria({@required this.ICONE, @required this.NOME, this.CORHEX}) {
    COR = hexColor(CORHEX);
  }

  Color hexColor(String hexCode) {
    String color = '0xff' + hexCode;
    color = color.replaceAll('#', '');
    int colorint = int.parse(color);
    return Color(colorint);
  }

  Categoria.fromMap(Map<String, dynamic> map) {
    NOME = map['NOME'];
    ID = map['ID'];
    CORHEX = map['COR'];
    COR = hexColor(CORHEX);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'NOME': NOME, 'ID': ID, 'COR': CORHEX};
    return map;
  }
}
