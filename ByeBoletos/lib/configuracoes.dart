import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:brasil_fields/brasil_fields.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  TimeOfDay horario;
  TextEditingController horarioCTL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.alternate_email),
                      hintText: 'Qual o seu username?',
                      labelText: 'Nome de usuário'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) => EmailValidator.validate(value)
                      ? null
                      : "Entre um email válido",
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Qual o seu email?',
                      labelText: 'E-mail'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    TelefoneInputFormatter()
                  ],
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Qual o seu telefone?',
                      labelText: 'Telefone'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: horarioCTL,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((horaSelecionada) {
                      setState(() {
                        horario = horaSelecionada;
                        horarioCTL.text =
                            '${horaSelecionada.hour}:${horaSelecionada.minute}';
                      });
                    });
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.access_alarms_outlined),
                      hintText: 'Escolha o melhor horário para notificações',
                      labelText: 'Melhor horário para notificações'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: update banco
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
