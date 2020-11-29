import 'package:flutter/material.dart';
import 'package:ByeBoletos/models/boleto.dart';

class CardBoleto extends StatelessWidget {
  final Boleto boleto;
  CardBoleto({@required this.boleto});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Text(
            boleto.titulo,
            style: TextStyle(fontSize: 25),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'R\$ ${boleto.valor}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Vencimento: ${boleto.dataVencimento.day}/${boleto.dataVencimento.month}',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
