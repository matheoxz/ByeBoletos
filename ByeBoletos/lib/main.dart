import 'package:ByeBoletos/configuracoes.dart';
import 'package:ByeBoletos/insercao_boleto.dart';
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
      debugShowCheckedModeBanner: false,
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
  List<Dismissible> cards = [];

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbCTL = DAO.instance;
  List<Map<String, dynamic>> boletos;
  List<Dismissible> cards = [];

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
        boletos = value;
        criaListaCard(boletos);
      });
    });
  }

  Future<List<Map<String, dynamic>>> returnBoletos() async {
    return await dbCTL.selectBoleto();
  }

  void criaListaCard(List<Map<String, dynamic>> boletos) {
    int index = 0;
    boletos.forEach((element) {
      Boleto _bol = Boleto.fromMap(element);
      _bol.getCategoria(element).then((value) {
        cards.add(Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) {
              try {
                setState(() {
                  dbCTL.deleteBoleto(_bol.ID);
                  cards.removeAt(index);
                  boletos.removeWhere((item) => item == element);
                });
              } catch (e) {
                /*Builder(builder: (BuildContext context) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Erro ao deletar boleto, tente novamente!'),
                  ));
                });*/
              }
            },
            child: CardBoleto(
              boleto: _bol,
            )));
      });
      index++;
    });
    setState(() {});
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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => _configPage(context),
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
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
        automaticallyImplyLeading: false,
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
          automaticallyImplyLeading: false,
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
        child: ListView(
          children: cards,
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
