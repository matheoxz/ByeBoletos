import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DAO {
  static Database _database;

  DAO._createInstance();

  static final DAO instance = DAO._createInstance();

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
        await openDatabase(path, version: 2, onCreate: _createDb);
    return boletosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE CATEGORIA(
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      NOME TEXT NOT NULL,
      COR TEXT NOT NULL,
      ICONE TEXT);
      ''');
    await db.execute('''
      CREATE TABLE BOLETO(
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      TITULO TEXT NOT NULL,
      DESCRICAO TEXT,
      DATACHEGADA TEXT NOT NULL,
      DATAVENCIMENTO TEXT NOT NULL,
      CODIGO TEXT,
      VALOR DOUBLE NOT NULL,
      ARQUIVO TEXT,
      CATEGORIA INTEGER NOT NULL,
      FOREIGN KEY (CATEGORIA) REFERENCES CATEGORIA(ID)
      );
      ''');
    await db.execute('''
      CREATE TABLE USUARIO(
      NOME TEXT NOT NULL,
      TELEFONE TEXT NOT NULL,
      SENHA TEXT NOT NULL,
      EMAIL TEXT NOT NULL,
      HORARIOPREFERIDO TEXT NOT NULL
      );
      ''');
    await db.execute('''
      CREATE TABLE HISTORICO(
      DATAHORA TEXT NOT NULL,
      IDBOLETO INTEGER NOT NULL,
      ACAO TEXT NOT NULL,
      FOREIGN KEY (IDBOLETO) REFERENCES BOLETO(ID),
      PRIMARY KEY (DATAHORA, IDBOLETO)
      );
      ''');

    await db.execute('''
    INSERT INTO CATEGORIA(NOME, COR) 
    VALUES('Categoria', '#bfb3b2');
    ''');
    await db.execute('''
    INSERT INTO CATEGORIA(NOME, COR) 
    VALUES('Moradia', '#dbaeeb');
    ''');
    await db.execute('''
    INSERT INTO CATEGORIA(NOME, COR) 
    VALUES('Mobilidade', '#b6ebae');
    ''');
    await db.execute('''
    INSERT INTO CATEGORIA(NOME, COR) 
    VALUES('Compras Online', '#aee9eb');
    ''');
    await db.execute('''
    INSERT INTO CATEGORIA(NOME, COR) 
    VALUES('Lazer', '#f0de7d');
    ''');
    await db.execute('''
    INSERT INTO CATEGORIA(NOME, COR) 
    VALUES('Mercado', '#f09892');
    ''');
    await db.execute('''
    INSERT INTO CATEGORIA(NOME, COR) 
    VALUES('Contas', '#f7a6e8');
    ''');
  }

/***********INSERT***********/

  Future<int> insertCategoria(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("CATEGORIA", row);
  }

  Future<int> insertBoleto(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("BOLETO", row);
  }

  Future<int> insertUsuario(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("USUARIO", row);
  }

  Future<int> insertHistorico(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("HISTORICO", row);
  }

/***********UPDATE***********/

  Future<int> updateCategoria(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update("CATEGORIA", row);
  }

  Future<int> updateBoleto(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update("BOLETO", row);
  }

  Future<int> updateUsuario(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update("USUARIO", row);
  }

  Future<int> updateHistorico(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update("HISTORICO", row);
  }

/***********DELETE***********/

  Future<int> deleteCategoria(int id) async {
    Database db = await instance.database;
    return await db.delete("CATEGORIA", where: "ID = ?", whereArgs: [id]);
  }

  Future<int> deleteBoleto(int id) async {
    Database db = await instance.database;
    return await db.delete("BOLETO", where: "ID = ?", whereArgs: [id]);
  }

  Future<int> deleteUsuario(int id) async {
    Database db = await instance.database;
    return await db.delete("USUARIO", where: "ID = ?", whereArgs: [id]);
  }

  Future<int> deleteHistorico(int idboleto, String datahora) async {
    Database db = await instance.database;
    return await db.delete("HISTORICO",
        where: "IDBOLETO = ? AND DATAHORA = ?",
        whereArgs: [idboleto, datahora]);
  }

  /***********SELECT***********/

  Future<List<Map<String, dynamic>>> selectCategoria() async {
    Database db = await instance.database;
    return await db.query("CATEGORIA");
  }

  Future<List<Map<String, dynamic>>> selectCategoriaID(int id) async {
    Database db = await instance.database;
    return await db.query("CATEGORIA", where: "ID = ?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> selectBoleto() async {
    Database db = await instance.database;
    return await db.query("BOLETO");
  }

  Future<List<Map<String, dynamic>>> selectUsuario() async {
    Database db = await instance.database;
    return await db.query("USUARIO");
  }

  Future<List<Map<String, dynamic>>> selectHistorico() async {
    Database db = await instance.database;
    return await db.query("HISTORICO");
  }
}
