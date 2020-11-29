import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ByeBoletos/models/boleto.dart';

class BoletoHelper {
  static BoletoHelper _boletoHelper;
  static Database _database;
  static final table = 'BOLETO';

  BoletoHelper._createInstance();

  factory BoletoHelper() {
    if (_boletoHelper == null) {
      _boletoHelper = BoletoHelper._createInstance();
    }
    return _boletoHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'byeboletos.db';

    var boletosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return boletosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE BOLETOS(
          cod INTEGER PRIMARY KEY AUTOINCREMENT, 
          titulo TEXT, 
          valor REAL, 
          dataChegada TEXT, 
          dataVencimento TEXT, 
          pathArquivo TEXT, 
          descricao TEXT);''');
  }

  Future<int> insert(Map<String, dynamic> map) {}
}
