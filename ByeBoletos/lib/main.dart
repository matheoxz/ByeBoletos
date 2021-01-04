import 'package:ByeBoletos/configuracoes.dart';
import 'package:ByeBoletos/insercao_boleto.dart';
import 'package:ByeBoletos/models/categoria.dart';
import 'package:ByeBoletos/widgets/card_boleto.dart';
import 'package:ByeBoletos/models/boleto.dart';
import 'package:flutter/material.dart';
import 'helpers/DAO.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ByeBoletos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbCTL = DAO.instance;
  List<Map<String, dynamic>> boletos;
  List<CardBoleto> cards = [];

  void _configPage(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Configuracoes()),
    );
  }

  @override
  void initState() {
    returnBoletos().then((value) {
      print(value);
      setState(() {
        print('oi2');
        boletos = value;
      });
    });
  }

  Future<List<Map<String, dynamic>>> returnBoletos() async {
    print('oi');
    return await dbCTL.selectBoleto();
  }

  @override
  Widget build(BuildContext context) {
    if (boletos == null) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      );
    } else if (boletos.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(':('),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Você ainda não adicionou nenhum boleto',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.all(40),
                child: Icon(
                  Icons.sms_failed,
                  size: 100,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                context: context,
                builder: (context) {
                  return FormsBoleto();
                });
          },
          tooltip: 'Adicionar Boleto',
          child: Icon(Icons.add),
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('ByeBoletos'),
        actions: [
          IconButton(
              onPressed: () => _configPage(context),
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
        bottom: AppBar(
          elevation: 0.0,
          title: Container(
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Pesquisar',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90))),
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CardBoleto(
              boleto: Boleto(
                TITULO: 'Condomínio',
                VALOR: 280.00,
                DATACHEGADA: DateTime.utc(2020, 10, 10),
                DATAVENCIMENTO: DateTime.utc(2020, 11, 11),
                CATEGORIA:
                    Categoria(ICONE: ",", NOME: 'Teste', CORHEX: '#ded571'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              context: context,
              builder: (context) {
                return FormsBoleto();
              });
        },
        tooltip: 'Adicionar Boleto',
        child: Icon(Icons.add),
      ),
    );
  }
}
/*Container(
                  color: Color(0xFF737373),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: */
