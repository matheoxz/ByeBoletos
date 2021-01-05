import 'package:ByeBoletos/main.dart';
import 'package:ByeBoletos/models/boleto.dart';
import 'package:ByeBoletos/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'helpers/DAO.dart';

class FormsBoleto extends StatefulWidget {
  @override
  _FormsBoletoState createState() => _FormsBoletoState();
}

class _FormsBoletoState extends State<FormsBoleto> {
  DateTime chegada, vencimento;
  TextEditingController tituloCTL = TextEditingController(),
      chegadaCTL = TextEditingController(),
      vencimentoCTL = TextEditingController(),
      valorCTL = TextEditingController(),
      codigoCTL = TextEditingController();
  final dbCTL = DAO.instance;

  List<Map<String, dynamic>> categorias;
  List<String> categoriasNome = [];
  String ddValue;
  int id;
  double valor;

  @override
  void initState() {
    super.initState();
    returnCategorias().then((value) {
      print(value);
      setState(() {
        categorias = value;
        categorias.forEach((element) {
          categoriasNome.add(element['NOME']);
        });
        ddValue = categoriasNome[0];
        id = 1;
      });
    });
  }

  Future<List<Map<String, dynamic>>> returnCategorias() async {
    return await dbCTL.selectCategoria();
  }

  Widget dropdownCategoria() {
    return Container(
        //width: double.infinity,
        child: DropdownButton<String>(
            value: ddValue,
            isExpanded: true,
            items: categoriasNome.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (item) {
              setState(() {
                ddValue = item;
                id = categoriasNome.indexOf(item);
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16),
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: tituloCTL,
                decoration: InputDecoration(
                    icon: Icon(Icons.title),
                    hintText: 'Qual o nome do seu boleto?',
                    labelText: 'Título'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16),
              margin: EdgeInsets.all(10),
              child: dropdownCategoria(),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16),
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: chegadaCTL,
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2222))
                      .then((date) {
                    setState(() {
                      chegada = date;
                      chegadaCTL.text =
                          '${date.day}/${date.month}/${date.year}';
                    });
                  });
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.date_range_rounded),
                    hintText: 'Quando chegou seu boleto?',
                    labelText: 'Data chegada'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16),
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: vencimentoCTL,
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2222))
                      .then((date) {
                    setState(() {
                      vencimento = date;
                      vencimentoCTL.text =
                          '${date.day}/${date.month}/${date.year}';
                    });
                  });
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    hintText: 'Quando vence seu boleto?',
                    labelText: 'Data vencimento'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16),
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: valorCTL,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter()
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    hintText: 'Qual o valor em reais do seu boleto?',
                    labelText: 'Valor'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16),
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: codigoCTL,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.qr_code_rounded),
                    hintText: 'Qual o código do seu boleto? (opcional)',
                    labelText: 'Código'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Categoria cat = Categoria.fromMap(categorias[id]);
                  valorCTL.text = valorCTL.text.replaceAll('R\$', '');
                  valorCTL.text = valorCTL.text.replaceAll(',', '.');
                  valorCTL.text = valorCTL.text.replaceAll(' ', '');

                  Boleto bol = Boleto(
                      TITULO: tituloCTL.text,
                      VALOR: double.parse(valorCTL.text),
                      DATACHEGADA: chegada,
                      DATAVENCIMENTO: vencimento,
                      CATEGORIA: cat);

                  dbCTL.insertBoleto(bol.toMap());

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text('Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
