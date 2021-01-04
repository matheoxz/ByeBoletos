import 'package:flutter/material.dart';
import 'package:ByeBoletos/models/boleto.dart';

class CardBoleto extends StatelessWidget {
  final Boleto boleto;

  CardBoleto({@required this.boleto});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: boleto.CATEGORIA.COR,
        child: InkWell(
          splashColor: Colors.white,
          onTap: () {
            print(boleto.CATEGORIA.COR);
          },
          child: Container(
            height: 100,
            child: Center(
              child: ListTile(
                title: Text(
                  boleto.TITULO,
                  style: TextStyle(fontSize: 25),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'R\$ ${boleto.VALOR}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Text(
                      'Vencimento: ${boleto.DATAVENCIMENTO.day}/${boleto.DATAVENCIMENTO.month}',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
